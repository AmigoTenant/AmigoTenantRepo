﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Amigo.Tenant.Application.DTOs.Requests.Tracking
{
  
    public class UpdateLocationRequest
    {
        public string Code { get; set; }
        public string Name { get; set; }
        public Decimal Latitude { get; set; }
        public Decimal Longitude { get; set; }
        public string Address1 { get; set; }
        public string Address2 { get; set; }
        public string ZipCode { get; set; }

        public string LocationTypeCode { get; set; }
        public string ParentLocationCode { get; set; }
        public string CityCode { get; set; }

        public List<RegisterLocationCoordinateItem> Coordinates { get; set; }

    }


}
