using GeoTools.Controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GeoTools
{
    class Program
    {
        static void Main(string[] args)
        {
            // Uncomment the process you want to run

            //(new ImportCities()).run();
            //(new ImportStates()).run();
            //(new ImportEclipsePath()).run();
            //(new ExportEclipseAndStates()).run();
            //(new ExportAllStates()).run();
            //(new ExportPoints100()).run();
            //(new ExportEclipseCities()).run();
            (new ExportPointsKyBuffer()).run();
        }
    }
}
