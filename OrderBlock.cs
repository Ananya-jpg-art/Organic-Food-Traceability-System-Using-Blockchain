using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Organic_food
{
    public class OrderBlock
    {
        public string Orid { get; set; }
        public string Prid { get; set; }
        public string PrName { get; set; }
        public string PrQuantity { get; set; }
        public string PrPrice { get; set; }
        public string PrFromId { get; set; }
        public string PrFromType { get; set; }
        public string PrToId { get; set; }
        public string PrToType { get; set; }
        public string Date { get; set; }
        public string Time { get; set; }
        public string Previousblock { get; set; }
        public string block { get; set; }
    }
}