using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ClinicaWeb
{
    public class PersonaResumen
    {
        public string DocIdentidad { get; set; }
        public string NombreCompleto { get; set; }
        public bool Activo { get; set; }
        public string Rol { get; set; } // "ADMINISTRADOR", "MEDICO", "PACIENTE"
    }
}