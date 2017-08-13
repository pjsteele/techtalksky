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
    public class ImportCities
    {
        public void run()
        {
            try
            {
                Database db = new Database("DBConnect"); 

                // Open the GeoJSON file and read as is
                FileInfo fileInfo = new FileInfo("../../../../data/geoJson/us_cities.geojson");
                StreamReader reader = fileInfo.OpenText();
                string json = reader.ReadToEnd();
                reader.Close();

                // Convert the Json Text into an object
                FeatureCollection featureCollection = JsonConvert.DeserializeObject<FeatureCollection>(json);
                foreach (Feature feature in featureCollection.Features)
                {
                    string fieldsSql = "";
                    string valuesSql = "";

                    foreach (var property in feature.Properties)
                    {
                        fieldsSql += "[" + property.Key + "], ";
                        valuesSql += "'" + property.Value + "', ";
                    }

                    // Create the SQL command. Append the geography and geometry too
                    string sql = "Insert into cities (" + fieldsSql + "[geography], [geometry]) ";
                    sql += "values(" + valuesSql + "\r\n";

                    Point point = feature.Geometry as Point;
                    sql += " geography::STGeomFromText('POINT(" + point.Coordinates.Longitude + "," + point.Coordinates.Longitude + "'), 4326), \r\n";
                    sql += " geometry::STGeomFromText('POINT(" + point.Coordinates.Longitude + "," + point.Coordinates.Longitude + "'), 4326) ";
                    sql += ")";
                }
            }
            catch (Exception exception)
            {
                throw exception ;
            }
        }
    }
}
