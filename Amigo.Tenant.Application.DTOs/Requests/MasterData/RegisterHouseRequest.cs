﻿using Amigo.Tenant.Application.DTOs.Requests.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Amigo.Tenant.Application.DTOs.Requests.MasterData
{
    public class RegisterHouseRequest : AuditBaseRequest
    {
        public int? HouseId { get; set; }
        public string Name { get; set; }
        public string Code { get; set; }
        public decimal? Latitude { get; set; }
        public decimal? Longitude { get; set; }
        public string Address { get; set; }
        public string PhoneNumber { get; set; }
        public string ShortName { get; set; }
        public decimal RentPrice { get; set; }
        public decimal RentDeposit { get; set; }
        public int HouseTypeId { get; set; }
        public int HouseStatusId { get; set; }
        public int? CityId { get; set; }
        //public int  coordinates: RegisterHouseCoordinateItem[];
    }
}
