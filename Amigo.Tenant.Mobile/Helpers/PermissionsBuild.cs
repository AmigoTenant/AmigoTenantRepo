﻿using System;
using System.Threading.Tasks;

namespace XPO.ShuttleTracking.Mobile.Helpers
{
    public class PermissionsBuild
    {
        private static Int32 c = 0;

        public PermissionsBuild()
        {
            // increment ID
            c++;

            // set task result
            Result = new TaskCompletionSource<bool>();

            // use Dialog to ask user
            AsPopup = true;

            // if Reason is null or empty, no popup
            Reason = "Se requiere los siguientes permisos";
        }

        /// <summary>
        /// Message to Prompt user for reason, optional
        /// </summary>
        /// <value>The reason.</value>
        public string Reason { get; set; }

        /// <summary>
        /// set to true to show popup implementation.  otherwise dialog
        /// </summary>
        /// <value><c>true</c> if as popup; otherwise, <c>false</c>.</value>
        public bool AsPopup { get; set; }

        public TaskCompletionSource<bool> Result { get; set; }

        /// <summary>
        /// Unique ID
        /// </summary>
        /// <value>The I.</value>
        public Int32 ID
        {
            get
            {
                return PermissionsBuild.c;
            }
        }

        public override int GetHashCode()
        {
            return c.GetHashCode();
        }

        public override bool Equals(object obj)
        {
            var t = obj as PermissionsBuild;
            if (t == null)
                return false;

            return t.ID == this.ID;
        }

        /// <summary>
        /// Permission to Add - see: Manifest.Permission. // Manifest.Permission_group.;
        /// </summary>
        public string[] Permissions { get; set; }

        /// <summary>
        /// Permission To Test see: Manifest.Permission. // Manifest.Permission_group.;
        /// </summary>
        /// <value>The permission to test.</value>
        public string PermissionToTest { get; set; }

        public string desc { get; set; }
    }
}
