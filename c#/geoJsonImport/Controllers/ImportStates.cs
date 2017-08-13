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
                    FeatureCollection featureCollection = JsonConvert.DeserializeObject<FeatureCollection>(json);
                    foreach (Feature feature in featureCollection.Features)
                    {
                        string fieldsSQL = "";
                        string valuesSQL = "";
                        foreach (var property in feature.Properties)
                        {
                            fieldsSQL += "[" + property.Key + "],";
                            valuesSQL += "'" + property.Value.ToString().Replace("'"," ") + "',";
                        }

                        string geomString = createGeomString(feature);

                        string sql = "Insert into states ( " + fieldsSQL + "[geography], [geometry]) values(" + valuesSQL;
                        sql += geomString + "," + geomString + ")";

                        db.Execute(sql);
                    }
                }
            }
            catch (Exception exception)
            {
                throw exception ;
            }
        }

        private string createGeomString(Feature feature)
        {
            MultiPolygon polygons = feature.Geometry as MultiPolygon;

            return "";
        }
    }
}
