using System;
using System.Collections.Generic;
using System.Configuration;
using System.Web.UI;
using MySql.Data.MySqlClient;
using Newtonsoft.Json;  // Asegúrate de tener instalado el paquete NuGet Newtonsoft.Json

namespace WebApplication2
{
    public partial class dashboard : Page
    {
        // Títulos de los 10 gráficos
        public string[] TituloGraficos = new string[]
        {
            "Usuarios por Tipo",
            "Animales por Especie",
            "Salud de los Animales",
            "Estado de Adopciones",
            "Actividad de Voluntarios",
            "Frecuencia de Voluntariado",
            "Donaciones por Año",
            "Sexo de los Animales",
            "Estado de los Animales",
            "Top 5 Refugios con más Animales"
        };

        // Variables JSON para cada indicador
        public string usuarios_tipo, animales_especie, salud_animales,
                      estado_adopciones, actividades_voluntarios,
                      frecuencia_voluntariado, donaciones_anio,
                      sexo_animales, estado_animales, animales_por_refugio;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Carga de datos siempre al recargar la página
            usuarios_tipo = GetIndicadorJson("usuarios_tipo");
            animales_especie = GetIndicadorJson("animales_especie");
            salud_animales = GetIndicadorJson("salud_animales");
            estado_adopciones = GetIndicadorJson("estado_adopciones");
            actividades_voluntarios = GetIndicadorJson("actividades_voluntarios");
            frecuencia_voluntariado = GetIndicadorJson("frecuencia_voluntariado");
            donaciones_anio = GetIndicadorJson("donaciones_anio");
            sexo_animales = GetIndicadorJson("sexo_animales");
            estado_animales = GetIndicadorJson("estado_animales");
            animales_por_refugio = GetIndicadorJson("animales_por_refugio");
        }

        private string GetIndicadorJson(string indicador)
        {
            string connStr = ConfigurationManager
                .ConnectionStrings["conexionDatos"]
                .ConnectionString;

            string query = "";
            switch (indicador)
            {
                case "usuarios_tipo":
                    query = "SELECT tipo_usuario, COUNT(*) as total " +
                            "FROM usuario GROUP BY tipo_usuario " +
                            "ORDER BY total DESC";
                    break;
                case "animales_especie":
                    query = "SELECT especie, COUNT(*) as total " +
                            "FROM animal GROUP BY especie " +
                            "ORDER BY total DESC";
                    break;
                case "salud_animales":
                    query = "SELECT estado_salud, COUNT(*) as total " +
                            "FROM animal GROUP BY estado_salud " +
                            "ORDER BY total DESC";
                    break;
                case "estado_adopciones":
                    query = "SELECT estado, COUNT(*) as total " +
                            "FROM adopcion GROUP BY estado " +
                            "ORDER BY total DESC";
                    break;
                case "actividades_voluntarios":
                    query = "SELECT actividad, COUNT(*) as total " +
                            "FROM voluntario GROUP BY actividad " +
                            "ORDER BY total DESC";
                    break;
                case "frecuencia_voluntariado":
                    query = "SELECT frecuencia, COUNT(*) as total " +
                            "FROM voluntario GROUP BY frecuencia " +
                            "ORDER BY total DESC";
                    break;
                case "donaciones_anio":
                    query = "SELECT YEAR(fecha) AS anio, SUM(monto) AS total " +
                            "FROM donacion GROUP BY anio " +
                            "ORDER BY total DESC";
                    break;
                case "sexo_animales":
                    query = "SELECT sexo, COUNT(*) as total " +
                            "FROM animal GROUP BY sexo " +
                            "ORDER BY total DESC";
                    break;
                case "estado_animales":
                    query = "SELECT estado, COUNT(*) as total " +
                            "FROM animal GROUP BY estado " +
                            "ORDER BY total DESC";
                    break;
                case "animales_por_refugio":
                    query = "SELECT id_refugio, COUNT(*) as total " +
                            "FROM animal GROUP BY id_refugio " +
                            "ORDER BY total DESC LIMIT 5";
                    break;
                default:
                    return "{\"labels\":[],\"values\":[]}";
            }


            return EjecutarConsultaJson(connStr, query);
        }

        private string EjecutarConsultaJson(string connStr, string query)
        {
            // Listas para labels y values
            var labels = new List<string>();
            var values = new List<int>();

            using (var conn = new MySqlConnection(connStr))
            using (var cmd = new MySqlCommand(query, conn))
            {
                conn.Open();
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        labels.Add(reader[0].ToString());
                        values.Add(Convert.ToInt32(reader[1]));
                    }
                }
            }

            // Objeto anónimo con los datos
            var resultado = new
            {
                labels = labels,
                values = values
            };

            // Serializar a JSON con Newtonsoft.Json
            return JsonConvert.SerializeObject(resultado);
        }
    }
}
