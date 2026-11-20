<?xml version="1.0" encoding="UTF-8"?>



<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns="http://www.w3.org/2000/svg"
    version="3.0">
    
    <xsl:output method="xml" encoding="UTF-8" indent="yes"/>
    
    <xsl:template match="/">
        
        <xsl:variable name="villes"
            select="meteo/mesure[@date='2005-02-01']/ville"/>
        
        <xsl:variable name="maxTemp"
            select="max($villes/@temperature ! xs:decimal(.))"/>
        
        <svg width="1000" height="650" viewBox="0 0 1000 650">
            
            <title>Graphique des températures</title>
            
            <rect width="1000" height="650" fill="#f1f5f9"/>
            
            <!-- Titre -->
            <text x="500" y="45"
                text-anchor="middle"
                font-size="28"
                font-weight="bold"
                fill="#1e3a8a">
                METEO - TEMPERATURES PAR VILLE
            </text>
            
            <text x="500" y="75"
                text-anchor="middle"
                font-size="16"
                fill="#64748b">
                Date : 2005-02-01
            </text>
            
            <!-- Axe vertical -->
            <line x1="100" y1="120"
                x2="100" y2="520"
                stroke="#1e293b" stroke-width="3"/>
            
            <!-- Axe horizontal -->
            <line x1="100" y1="520"
                x2="930" y2="520"
                stroke="#1e293b" stroke-width="3"/>
            
            <!-- Barres dynamiques -->
            <xsl:for-each select="$villes">
                
                <xsl:variable name="index" select="position()"/>
                <xsl:variable name="temp"
                    select="xs:decimal(@temperature)"/>
                
                <xsl:variable name="barHeight"
                    select="if ($maxTemp gt 0)
                    then $temp div $maxTemp * 330
                    else 0"/>
                
                <rect x="{120 + ($index - 1) * 130}"
                    y="{520 - $barHeight}"
                    width="75"
                    height="{$barHeight}"
                    rx="8"
                    fill="#0ea5e9"/>
                
                <!-- Valeur -->
                <text x="{157.5 + ($index - 1) * 130}"
                    y="{510 - $barHeight}"
                    text-anchor="middle"
                    font-size="18"
                    font-weight="bold"
                    fill="#1e40af">
                    <xsl:value-of select="$temp"/>°C
                </text>
                
                <!-- Nom de ville -->
                <text x="{157.5 + ($index - 1) * 130}"
                    y="550"
                    text-anchor="middle"
                    font-size="15"
                    fill="#334155">
                    <xsl:value-of select="@nom"/>
                </text>
                
            </xsl:for-each>
            
            <!-- Légende -->
            <rect x="380" y="590"
                width="20" height="20"
                rx="4" fill="#0ea5e9"/>
            
            <text x="410" y="606"
                font-size="15" fill="#334155">
                Température en degrés Celsius
            </text>
            
        </svg>
        
    </xsl:template>
    
</xsl:stylesheet>
