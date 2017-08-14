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
    public class ImportEclipsePath
    {
        public void run()
        {
            try
            {
                Database db = new Database("DBConnect");

                FileInfo fileInfo = new FileInfo("../../../../data/geoJson/eclipse.geojson");
                StreamReader reader = fileInfo.OpenText();
                string json = reader.ReadToEnd();
                reader.Close();

                // Convert the Json Text into an object
                FeatureCollection featureCollection = JsonConvert.DeserializeObject<FeatureCollection>(json);

                // This json only has one feature
                Feature feature = featureCollection.Features.First();
                LineString lineString = feature.Geometry as LineString;

                string pointsString = "LINESTRING(";
                for (int i = 0; i < lineString.Coordinates.Count; i++)
                {
                    if (i > 0) { pointsString += ","; }
                    pointsString += lineString.Coordinates[i].Longitude + " " + lineString.Coordinates[i].Latitude;
                }
                pointsString += ")";

                string sql = "Insert into eclipse ([geography], [geometry]) values(";

                Point point = feature.Geometry as Point;
                sql += " geography::STGeomFromText('" + pointsString + "', 4326), \r\n";
                sql += " geometry::STGeomFromText('" + pointsString + "', 4326) ";
                sql += ")";

                db.Execute(sql);

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
