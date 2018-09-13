﻿using System.Threading.Tasks;
using Amigo.Tenant.CommandModel.Models;
using Amigo.Tenant.Infrastructure.Persistence.Abstract;

namespace Amigo.Tenant.CommandHandlers.Extensions
{
    public static class AmigoTenantTUserExtensions
    {
        public static async Task<bool> ExistsByUserName(this IRepository<AmigoTenantTUser> repository,string userName)
        {
            return await repository.FirstAsync(x => x.Username == userName && x.RowStatus.Value) != null;
        }
    }
}
