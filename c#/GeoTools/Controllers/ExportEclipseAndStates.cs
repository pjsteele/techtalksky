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
    public class ExportEclipseAndStates
    {
        public void run()
        {
            try
            {
                Database db = new Database("DBConnect");
                var rows = db.Fetch<dynamic>(";exec StatesIntersectEclipseJson");

                FeatureCollection fc = new FeatureCollection();
                foreach (var row in rows)
                {
                    fc.Features.Add(createFeature(row));    
                }

                FileInfo fileInfo = new FileInfo("c:/temp/eclipseAndStates.geojson");
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

        private Feature createFeature(dynamic row)
        {
            dynamic geoJson = JsonConvert.DeserializeObject(row.json);
            string geometryType = geoJson.type;
            IGeometryObject geometry = null;

            switch (geometryType)
            {
                case "Polygon":
                    geometry = JsonConvert.DeserializeObject<Polygon>(row.json);
                    break;
                case "MultiPolygon":
                    geometry = JsonConvert.DeserializeObject<MultiPolygon>(row.json);
                    break;
                case "LineString":
                    geometry = JsonConvert.DeserializeObject<LineString>(row.json);
                    break;
                default:
                    throw new Exception("Unexpected Geometry Type");
            }

            Feature feature = new Feature(geometry);
            feature.Properties.Add("name", row.name);

            return feature;
        }
    }
}
