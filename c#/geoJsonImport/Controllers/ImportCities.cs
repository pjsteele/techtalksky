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

                // Use a different list of cities to get more data
                FileInfo fileInfo = new FileInfo("../../../../data/geoJson/us_cities.geojson");
                StreamReader reader = fileInfo.OpenText();
                string json = reader.ReadToEnd();
                reader.Close();

                Dictionary<string, int> populations = new Dictionary<string, int>();
                FeatureCollection featureCollection = JsonConvert.DeserializeObject<FeatureCollection>(json);
                foreach (Feature feature in featureCollection.Features)
                {
                    string key = getKey(feature.Properties["ST"] , feature.Properties["AREANAME"]);
                    if (!populations.ContainsKey(key))
                    {
                        populations.Add(key, Convert.ToInt32(feature.Properties["POP2000"]));
                    }
                }


                // Open the GeoJSON file and read as is
                fileInfo = new FileInfo("../../../../data/geoJson/cities.geojson");
                reader = fileInfo.OpenText();
                json = reader.ReadToEnd();
                reader.Close();

                // Convert the Json Text into an object
                featureCollection = JsonConvert.DeserializeObject<FeatureCollection>(json);
                foreach (Feature feature in featureCollection.Features)
                {
                    string key = getKey(feature.Properties["state"], feature.Properties["city"]);
                    if (populations.ContainsKey(key))
                    {
                        string sql = "Insert into cities ([city], [state], [population], [geography], [geometry]) values(";

                        sql += "'" + feature.Properties["city"].ToString().Replace("'", "''") + "',";
                        sql += "'" + feature.Properties["state"] + "',";
                        sql += populations[key] + ",\r\n";

                        Point point = feature.Geometry as Point;
                        sql += " geography::STGeomFromText('POINT(" + point.Coordinates.Longitude + " " + point.Coordinates.Latitude + ")', 4326), \r\n";
                        sql += " geometry::STGeomFromText('POINT(" + point.Coordinates.Longitude + " " + point.Coordinates.Latitude + ")', 4326) ";
                        sql += ")";

                        db.Execute(sql);
                    }
                }
            }
            catch (Exception exception)
            {
                throw exception ;
            }
        }

        private string getKey(object state, object city)
        {
            string key = state.ToString() + "-" + city.ToString();
            key = key.Replace(" ", "-");
            key = key.ToUpper();

            return key;
        }
    }
}
