// Animation Observer
const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.classList.add('active');
        }
    });
});
document.querySelectorAll('.reveal-up').forEach((el) => observer.observe(el));

// ROI Calculator (Home Page)
const billRange = document.getElementById('billRange');
if (billRange) {
    billRange.addEventListener('input', function () {
        // Validation
        let bill = parseInt(this.value);
        const displayEl = document.getElementById('billValDisplay');
        if (displayEl) {
            displayEl.innerText = "₹ " + bill.toLocaleString();
        }

        // Logic: Annual Savings = (Monthly Bill * 12) * 0.90 (90% offset)
        let annual = (bill * 12) * 0.9;
        let fiveYear = annual * 5;

        document.getElementById('annualSave').innerText = Math.round(annual).toLocaleString();
        document.getElementById('fiveYearSave').innerText = Math.round(fiveYear).toLocaleString();
    });
}

// Smart Contact Form Logic
let userSelection = { type: '', bill: '' };

function selectOption(category, value) {
    userSelection[category] = value;

    // UI Update
    // Find options in current step
    let currentStepId = category === 'type' ? 'step1' : 'step2';
    document.querySelectorAll(`#${currentStepId} .option-card`).forEach(el => el.classList.remove('selected'));
    event.currentTarget.classList.add('selected');

    // Store in hidden input
    if (category === 'type') document.getElementById('custType').value = value;
    if (category === 'bill') document.getElementById('custBill').value = value;

    // Transition
    setTimeout(() => {
        if (category === 'type') {
            document.getElementById('step1').classList.add('hidden');
            document.getElementById('step2').classList.remove('hidden');
        } else if (category === 'bill') {
            document.getElementById('step2').classList.add('hidden');
            document.getElementById('step3').classList.remove('hidden');
            generateSuggestion();
        }
    }, 400);
}

function generateSuggestion() {
    const suggestionBox = document.getElementById('aiSuggestion');
    let msg = "";

    if (userSelection.type === 'Industry') {
        msg = "<strong>🤖 AI Recommendation:</strong> For Industrial power bills of this range, we recommend our <strong>Captive Open Access</strong> or <strong>EPC MW Scale</strong> solution. You can save up to 40% on tariff immediately.";
    } else if (userSelection.type === 'Home') {
        msg = "<strong>🤖 AI Recommendation:</strong> For your home, a <strong>5kW - 10kW On-Grid System</strong> with net metering would be perfect. It will likely eliminate 90% of your bill.";
    } else {
        msg = "<strong>🤖 AI Recommendation:</strong> For offices, we suggest a <strong>Genset-Sync Solar System</strong> to reduce diesel costs during outages.";
    }

    // Typewriter effect for expert feel
    suggestionBox.innerHTML = '';
    let i = 0;
    const typeWriter = () => {
        if (i < msg.length) {
            suggestionBox.innerHTML += msg.charAt(i);
            i++;
            setTimeout(typeWriter, 20); // Speed of typing
        }
    };

    // Convert HTML string to text for typing (simplified for demo, or just fade in)
    // Actually, typing HTML tags is messy. Let's do a Fade In effect instead for reliable "Expert" feel.
    suggestionBox.innerHTML = msg;
    suggestionBox.style.opacity = '0';
    suggestionBox.style.transform = 'translateY(10px)';
    suggestionBox.style.transition = 'all 0.5s ease';

    setTimeout(() => {
        suggestionBox.style.opacity = '1';
        suggestionBox.style.transform = 'translateY(0)';
    }, 100);
}

// Make selectOption global
window.selectOption = selectOption;
window.toggleChat = function () {
    const chatBox = document.getElementById('chatBox');
    if (chatBox) chatBox.classList.toggle('open');
}

// Preloader (if exists)
window.addEventListener('load', () => {
    const pre = document.getElementById('preloader');
    if (pre) {
        pre.style.opacity = '0';
        setTimeout(() => pre.style.display = 'none', 500);
    }
});

// Mobile Menu Logic
function toggleMenu() {
    const navLinks = document.querySelector('.nav-links');
    const hamburger = document.querySelector('.hamburger i');

    navLinks.classList.toggle('active');

    // Icon toggle
    if (navLinks.classList.contains('active')) {
        hamburger.classList.remove('fa-bars');
        hamburger.classList.add('fa-times');
    } else {
        hamburger.classList.remove('fa-times');
        hamburger.classList.add('fa-bars');
    }
}
window.toggleMenu = toggleMenu;

// Close menu when clicking a link
document.querySelectorAll('.nav-links a').forEach(link => {
    link.addEventListener('click', () => {
        const navLinks = document.querySelector('.nav-links');
        if (navLinks.classList.contains('active')) {
            toggleMenu();
        }
    });
});
