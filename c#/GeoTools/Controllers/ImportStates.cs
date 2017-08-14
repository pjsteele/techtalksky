using GeoJSON.Net;
using GeoJSON.Net.Feature;
using GeoJSON.Net.Geometry;
using Newtonsoft.Json;
using PetaPoco;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GeoTools.Controllers
{
    public class ImportStates
    {
        public void run()
        {
            try
            {
                Database db = new Database("DBConnect");

                // Use a different list of cities to get more data
                DirectoryInfo dirInfo = new DirectoryInfo("../../../../data/geoJson/states");
                foreach (FileInfo fileInfo in dirInfo.GetFiles())
                {
                    StreamReader reader = fileInfo.OpenText();
                    string json = reader.ReadToEnd();
                    reader.Close();

                    // Convert the Json Text into an object
                    Feature feature = JsonConvert.DeserializeObject<Feature>(json);
                    string fieldsSQL = "";
                    string valuesSQL = "";
                    foreach (var property in feature.Properties)
                    {
                        fieldsSQL += "[" + property.Key + "],";
                        valuesSQL += "'" + property.Value.ToString().Replace("'"," ") + "',";
                    }

                    string geomString = createGeomString(feature);

                    string sql = "Insert into states ( " + fieldsSQL + "[geography], [geometry]) values(" + valuesSQL;
                    sql += "geography::STGeomFromText('" + geomString + "', 4326), ";
                    sql += "geometry::STGeomFromText('" + geomString + "', 4326))";

                    db.Execute(sql); 
                }
            }
            catch (Exception exception)
            {
                throw exception ;
            }
        }

        private string createGeomString(Feature feature)
        {
            try
            {
                string geom = "";

                switch (feature.Geometry.Type)
                {
                    case GeoJSONObjectType.Polygon:
                        buildPolygon(feature.Geometry, ref geom);
                        geom = "POLYGON(" + geom + ")";
                        break;

                    case GeoJSONObjectType.MultiPolygon:
                        buildPolygon(feature.Geometry, ref geom);
                        geom = "MULTIPOLYGON(" + geom + ")";
                        break;

                    default:
                        throw new Exception("Unexpected geometry type");
                }

                return geom;
            }
            catch (Exception exception)
            {
                throw exception;
            }
        }

        private void buildPolygon(IGeometryObject geometry, ref string value)
        {
            try
            {               
                switch (geometry.Type)
                {
                    case GeoJSONObjectType.Polygon:
                        Polygon polygon = geometry as Polygon;
                        var coords = polygon.Coordinates[0];

                        string pointsString = "(";
                        for (int i = 0; i < coords.Coordinates.Count; i++)
                        {
                            if (i > 0) { pointsString += ","; }
                            pointsString += coords.Coordinates[i].Longitude + " " + coords.Coordinates[i].Latitude;
                        }
                        pointsString += ")";
                        value += pointsString;
                        break;

                    case GeoJSONObjectType.MultiPolygon:
                        MultiPolygon multiPolygon = geometry as MultiPolygon;
                        for (int i = 0; i < multiPolygon.Coordinates.Count; i++)
                        {
                            if (i > 0) { value += ","; }
                            value += "(";
                            buildPolygon(multiPolygon.Coordinates[i], ref value);
                            value += ")";
                        }
                        break;

                    default:
                        throw new Exception("Unexpectd geometry type");
                }

                
            }
            catch (Exception exception)
            {
                throw exception;
            }
        }
    }
}
