# Script to update all HTML pages with new branding and features
# This PowerShell script will be used to batch update all HTML files

$files = @(
    "products.html",
    "portfolio.html",
    "solutions.html",
    "maintenance.html",
    "contact.html"
)

foreach ($file in $files) {
    $path = "c:/Users/Dell/CascadeProjects/ShivaHeliosWebsite/$file"
    $content = Get-Content $path -Raw
    
    # Update logo branding
    $content = $content -replace '<span>SHIVA HELIOS</span>', '<span>SHIVA HELIOS<br><small style="font-size: 0.65rem; letter-spacing: 2px;">POWER SYSTEM</small></span>'
    
    # Add About link to navigation (if not present)
    if ($content -notmatch 'href="about.html"') {
        $content = $content -replace '(<li><a href="maintenance.html"[^>]*>O&M</a></li>)', '$1`r`n                <li><a href="about.html">About</a></li>'
    }
    
    # Add WhatsApp and Social before closing body tag
    if ($content -notmatch 'whatsapp-float') {
        $floatingHTML = @"

    <!-- WhatsApp Chatbot -->
    <div class="whatsapp-float">
        <a href="https://wa.me/918527147331?text=Hi%20Shiva%20Helios,%20I'm%20interested%20in%20your%20solar%20solutions" 
           target="_blank" class="whatsapp-btn" title="Chat with us on WhatsApp">
            <i class="fab fa-whatsapp"></i>
        </a>
    </div>

    <!-- Social Media Float -->
    <div class="social-float">
        <a href="#" class="facebook" title="Follow us on Facebook" target="_blank">
            <i class="fab fa-facebook-f"></i>
        </a>
        <a href="#" class="instagram" title="Follow us on Instagram" target="_blank">
            <i class="fab fa-instagram"></i>
        </a>
        <a href="#" class="linkedin" title="Connect on LinkedIn" target="_blank">
            <i class="fab fa-linkedin-in"></i>
        </a>
    </div>

"@
        $content = $content -replace '(\s*<script src="script.js"></script>)', "$floatingHTML`r`n`$1"
    }
    
    # Update footer branding
    $content = $content -replace '<h4 style="margin:0; font-size: 1\.2rem;">SHIVA HELIOS</h4>', '<h4 style="margin:0; font-size: 1.2rem;">SHIVA HELIOS<br><small style="font-size: 0.7rem;">POWER SYSTEM</small></h4>'
    
    Set-Content $path -Value $content
    Write-Host "Updated $file"
}

Write-Host "All files updated successfully!"
"@
