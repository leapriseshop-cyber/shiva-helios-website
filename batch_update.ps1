# Common HTML snippets for updating all pages

$whatsappHTML = @'

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

'@

# Files to update
$files = @("portfolio.html", "solutions.html", "maintenance.html", "contact.html")

foreach ($file in $files) {
    try {
        $content = Get-Content "c:/Users/Dell/CascadeProjects/ShivaHeliosWebsite/$file" -Raw -ErrorAction Stop
        Write-Host "Processing $file..."
        
        # 1. Update logo in navbar
        $content = $content -replace '(<span>)SHIVA HELIOS(</span>)', '$1SHIVA HELIOS<br><small style="font-size: 0.65rem; letter-spacing: 2px;">POWER SYSTEM</small>$2'
        
        # 2. Add About link if missing
        if ($content -notmatch 'about.html') {
            $content = $content -replace '(<li><a href="maintenance\.html"[^>]*>O&M</a></li>)', '$1<li><a href="about.html">About</a></li>'
        }
        
        # 3. Update footer logo
        $content = $content -replace '(<h4 style="margin:0; font-size: 1\.2rem;">)SHIVA HELIOS(</h4>)', '$1SHIVA HELIOS<br><small style="font-size: 0.7rem;">POWER SYSTEM</small>$2'
        
        # 4. Add floating elements before closing body tag if not present
        if ($content -notmatch 'whatsapp-float') {
            $content = $content -replace '(\s*<script src="script\.js"></script>\s*</body>)', "$whatsappHTML`n    `$1"
        }
        
        Set-Content "c:/Users/Dell/CascadeProjects/ShivaHeliosWebsite/$file" -Value $content
        Write-Host "✓ Updated $file successfully"
    }
    catch {
        Write-Host "✗ Error updating $file : $_" -ForegroundColor Red
    }
}

Write-Host "`nAll updates complete!" -ForegroundColor Green
'@
