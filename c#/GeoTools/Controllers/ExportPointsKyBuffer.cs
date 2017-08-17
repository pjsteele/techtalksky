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
    public class ExportPointsKyBuffer
    {
        public void run()
        {
            try
            {
                Database db = new Database("DBConnect");
                var rows = db.Fetch<dynamic>(";exec ky100points");

                FeatureCollection fc = new FeatureCollection();
                foreach (var row in rows)
                {
                    dynamic geoJson = JsonConvert.DeserializeObject(row.json);
                    string geometryType = geoJson.type;
                    IGeometryObject geometry = null;

                    switch (geometryType)
                    {
                        case "Point":
                            geometry = JsonConvert.DeserializeObject<Point>(row.json);
                            break;
                        case "Polygon":
                            geometry = JsonConvert.DeserializeObject<Polygon>(row.json);
                            break;
                        case "MultiPolygon":
                            geometry = JsonConvert.DeserializeObject<MultiPolygon>(row.json);
                            break;
                        default:
                            throw new Exception("Unexpected Geometry Type");
                    }

                    Feature feature = new Feature(geometry);
                    feature.Properties.Add("city", row.city);
                    feature.Properties.Add("state", row.state);

                    fc.Features.Add(feature);    
                }

                FileInfo fileInfo = new FileInfo("c:/temp//pointsKY.geojson");
                StreamWriter writer = fileInfo.CreateText();
                string json = JsonConvert.SerializeObject(fc);
                writer.Write(json);
                writer.Close();
            }
            catch (Exception exception)
            {
                throw exception;
            }
        }
    }
}
