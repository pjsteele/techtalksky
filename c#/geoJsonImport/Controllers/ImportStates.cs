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

namespace Importer.Controllers
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

                    if (geomString != "") { db.Execute(sql); }
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
                        geom = "MULTIPOLYGON";
                        //https://blogs.msdn.microsoft.com/davidlean/2008/10/16/sql-2008-spatial-samples-part-9-of-9-handy-but-obvious-methods/
                        return "";
                        break;

                    default:
                        throw new Exception("Unexpected geometry type");
                }

                //MultiPolygon multiPolygon = feature.Geometry as MultiPolygon;
                //bool first0 = true;
                //foreach (var coords0 in multiPolygon.Coordinates)
                //{
                //    if (!first0) { geom += ", "; }
                //    geom += "(";

                //    bool first1 = true;
                //    foreach (var coords1 in coords0.Coordinates)
                //    {
                //        if (!first1) { geom += ", "; }
                //        geom += "(";

                //        bool first2 = true;
                //        foreach (var coords2 in coords1.Coordinates)
                //        {
                //            if (!first2) { geom += ","; }
                //            geom += coords2.Longitude + " " + coords2.Latitude;
                //            first2 = false;
                //        }

                //        first1 = false;
                //        geom += ")";
                //    }
                //    first0 = false;
                //    geom += ")";
                //}

                //geom += ")";

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
                        if (value != "") { value += ","; }
                        value += pointsString;
                        break;

                    case GeoJSONObjectType.MultiPolygon:
                        // Call again. We have more data to parse
                        buildPolygon(geometry, ref value);
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
