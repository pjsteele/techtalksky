using Importer.Controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Importer
{
    class Program
    {
        static void Main(string[] args)
        {
            //(new ImportCities()).run();
            (new ImportStates()).run();
        }
    }
}
