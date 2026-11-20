<?xml version="1.0" encoding="UTF-8"?>


<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="3.0">
    
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Weather Dashboard</title>
                
                <style>
                    * {
                    box-sizing: border-box;
                    }
                    
                    body {
                    margin: 0;
                    font-family: Arial, sans-serif;
                    background: #eef4fb;
                    color: #1e293b;
                    }
                    
                    .header {
                    background: linear-gradient(120deg, #0f172a, #0369a1);
                    color: white;
                    padding: 45px 20px;
                    text-align: center;
                    }
                    
                    .header h1 {
                    font-size: 34px;
                    margin: 0;
                    }
                    
                    .header p {
                    color: #bae6fd;
                    margin-top: 12px;
                    }
                    
                    .container {
                    max-width: 1000px;
                    margin: 35px auto;
                    padding: 0 20px;
                    }
                    
                    .date {
                    font-size: 20px;
                    font-weight: bold;
                    color: #0369a1;
                    margin-bottom: 25px;
                    }
                    
                    .city-grid {
                    display: grid;
                    grid-template-columns:
                    repeat(auto-fit, minmax(180px, 1fr));
                    gap: 18px;
                    margin-bottom: 35px;
                    }
                    
                    .city-card {
                    background: white;
                    padding: 25px;
                    border-radius: 15px;
                    text-align: center;
                    box-shadow: 0 5px 18px rgba(0,0,0,0.06);
                    border-bottom: 4px solid #0ea5e9;
                    }
                    
                    .city-card h3 {
                    color: #475569;
                    font-size: 17px;
                    }
                    
                    .city-card .icon {
                    font-size: 35px;
                    }
                    
                    .temperature {
                    font-size: 30px;
                    font-weight: bold;
                    color: #0284c7;
                    }
                    
                    .section-title {
                    margin-bottom: 18px;
                    color: #0f172a;
                    font-size: 23px;
                    }
                    
                    table {
                    width: 100%;
                    border-collapse: collapse;
                    background: white;
                    border-radius: 12px;
                    overflow: hidden;
                    box-shadow: 0 5px 18px rgba(0,0,0,0.05);
                    }
                    
                    th {
                    background: #075985;
                    color: white;
                    padding: 16px;
                    text-align: left;
                    }
                    
                    td {
                    padding: 15px;
                    border-bottom: 1px solid #e2e8f0;
                    }
                    
                    tr:nth-child(even) {
                    background: #f0f9ff;
                    }
                    
                    .stats {
                    display: grid;
                    grid-template-columns: repeat(2, 1fr);
                    gap: 20px;
                    margin-top: 30px;
                    }
                    
                    .stat-card {
                    background: linear-gradient(135deg, #0284c7, #38bdf8);
                    color: white;
                    padding: 25px;
                    border-radius: 14px;
                    text-align: center;
                    }
                    
                    .stat-card h3 {
                    font-size: 15px;
                    font-weight: normal;
                    }
                    
                    .stat-card p {
                    font-size: 28px;
                    font-weight: bold;
                    margin-bottom: 0;
                    }
                    
                    .footer {
                    text-align: center;
                    padding: 25px;
                    color: #64748b;
                    font-size: 13px;
                    }
                    
                    @media(max-width: 600px) {
                    .stats {
                    grid-template-columns: 1fr;
                    }
                    
                    .header h1 {
                    font-size: 25px;
                    }
                    }
                </style>
            </head>
            
            <body>
                
                <div class="header">
                    <h1>🌤️ WEATHER DASHBOARD</h1>
                    <p>Découvrez les conditions météorologiques par ville</p>
                </div>
                
                <div class="container">
                    
                    <xsl:for-each select="meteo/mesure[@date='2005-02-01']">
                        
                        <div class="date">
                            📅 Bulletin du :
                            <xsl:value-of select="@date"/>
                        </div>
                        
                        <h2 class="section-title">🌍 Températures des villes</h2>
                        
                        <div class="city-grid">
                            
                            <xsl:for-each select="ville">
                                
                                <div class="city-card">
                                    <div class="icon">🌡️</div>
                                    
                                    <h3>
                                        <xsl:value-of select="@nom"/>
                                    </h3>
                                    
                                    <div class="temperature">
                                        <xsl:value-of select="@temperature"/>°C
                                    </div>
                                </div>
                                
                            </xsl:for-each>
                            
                        </div>
                        
                        <h2 class="section-title">📊 Tableau récapitulatif</h2>
                        
                        <table>
                            <tr>
                                <th>Ville</th>
                                <th>Température</th>
                                <th>Unité</th>
                            </tr>
                            
                            <xsl:for-each select="ville">
                                <tr>
                                    <td>
                                        <xsl:value-of select="@nom"/>
                                    </td>
                                    
                                    <td>
                                        <strong>
                                            <xsl:value-of select="@temperature"/>
                                        </strong>
                                    </td>
                                    
                                    <td>°C</td>
                                </tr>
                            </xsl:for-each>
                        </table>
                        
                        <div class="stats">
                            
                            <div class="stat-card">
                                <h3>🏙️ Nombre de villes</h3>
                                <p>
                                    <xsl:value-of select="count(ville)"/>
                                </p>
                            </div>
                            
                            <div class="stat-card">
                                <h3>🌡️ Température moyenne</h3>
                                <p>
                                    <xsl:value-of
                                        select="format-number(avg(ville/@temperature ! xs:decimal(.)), '0.0')"/> °C
                                </p>
                            </div>
                            
                        </div>
                        
                    </xsl:for-each>
                    
                </div>
                
                <div class="footer">
                    Projet XML / XSLT 3.0 | Bulletin météorologique
                </div>
                
            </body>
        </html>
    </xsl:template>
    
</xsl:stylesheet>
