﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Amigo.Tenant.Application.DTOs.Requests.Tracking
{
    public class LatestPositionRequest
    {
        public List<int?> AmigoTenantTUsersIds { get; set; }
        public string TractorNumber { get; set; }
        public string ShipmentIdOrCostCenterCode { get; set; }
    }
}
