<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="dashboard.aspx.cs"
    Inherits="WebApplication2.dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
  
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>
        .charts-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 25px;
            padding: 30px;
        }

        .card {
            border: 1px solid #ddd;
            border-radius: 10px;
            padding: 15px;
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            text-align: center;
        }

        canvas {
            width: 100% !important;
            height: 250px !important;
        }

        .chart-title {
            font-weight: bold;
            margin-top: 10px;
            font-size: 1rem;
        }
    </style>

    <h2 class="text-center">Indicadores del Sistema</h2>

    <div class="charts-container">
        <% for (int i = 0; i < 10; i++) { %>
            <div class="card">
                <canvas id='chart<%= i + 1 %>'></canvas>
                <div class="chart-title"><%= TituloGraficos[i] %></div>
            </div>
        <% } %>
    </div>

    <script>
        const indicadores = {
            usuarios_tipo: <%= usuarios_tipo %>,
            animales_especie: <%= animales_especie %>,
            salud_animales: <%= salud_animales %>,
            estado_adopciones: <%= estado_adopciones %>,
            actividades_voluntarios: <%= actividades_voluntarios %>,
            frecuencia_voluntariado: <%= frecuencia_voluntariado %>,
            donaciones_anio: <%= donaciones_anio %>,
            sexo_animales: <%= sexo_animales %>,
            estado_animales: <%= estado_animales %>,
            animales_por_refugio: <%= animales_por_refugio %>
        };

        const titles = [
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
        ];

        const tiposGrafico = [
            "bar", "doughnut", "pie", "bar",
            "bar", "pie", "line", "doughnut",
            "pie", "bar"
        ];

        Object.keys(indicadores).forEach((key, i) => {
            const ctx = document.getElementById("chart" + (i + 1)).getContext("2d");
            const data = indicadores[key];

            new Chart(ctx, {
                type: tiposGrafico[i],
                data: {
                    labels: data.labels,
                    datasets: [{
                        label: titles[i],
                        data: data.values,
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: { position: 'top' },
                        title: {
                            display: false
                        }
                    }
                }
            });
        });
    </script>

</asp:Content>
