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
                string geom = "MULTIPOLYGON(";

                var debug = "";
                switch (feature.Geometry.Type)
                {
                    case GeoJSONObjectType.Polygon:
                        debug = "";
                        break;
                    case GeoJSONObjectType.MultiPolygon:
                        debug = "";
                        break;
                    default:
                        debug = "";
                        break;
                }

                MultiPolygon multiPolygon = feature.Geometry as MultiPolygon;
                bool first0 = true;
                foreach (var coords0 in multiPolygon.Coordinates)
                {
                    if (!first0) { geom += ", "; }
                    geom += "(";

                    bool first1 = true;
                    foreach (var coords1 in coords0.Coordinates)
                    {
                        if (!first1) { geom += ", "; }
                        geom += "(";

                        bool first2 = true;
                        foreach (var coords2 in coords1.Coordinates)
                        {
                            if (!first2) { geom += ","; }
                            geom += coords2.Longitude + " " + coords2.Latitude;
                            first2 = false;
                        }

                        first1 = false;
                        geom += ")";
                    }
                    first0 = false;
                    geom += ")";
                }

                geom += ")";

                return geom;
            }
            catch (Exception exception)
            {
                throw exception;
            }
        }
    }
}
