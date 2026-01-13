document.addEventListener('DOMContentLoaded', function() {
    // Inicializar efeitos
    initScrollAnimations();
    initCardInteractions();
    initNavbarEffects();
    initSmoothScroll();
});

// ========================================
// ANIMAÇÕES AO SCROLL
// ========================================

function initScrollAnimations() {
    const elements = document.querySelectorAll('.card, section h2, section h3');
    
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.animation = 'fadeIn 0.6s ease forwards';
                observer.unobserve(entry.target);
            }
        });
    }, {
        threshold: 0.1
    });
    
    elements.forEach(el => observer.observe(el));
}

// ========================================
// INTERAÇÕES COM CARDS
// ========================================

function initCardInteractions() {
    const cards = document.querySelectorAll('.card-hover');
    
    cards.forEach(card => {
        card.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-8px) scale(1.02)';
        });
        
        card.addEventListener('mouseleave', function() {
            this.style.transform = 'translateY(0) scale(1)';
        });
        
        // Clique em cards para navegar
        if (card.closest('a')) {
            card.style.cursor = 'pointer';
        }
    });
}

// ========================================
// EFEITOS DA NAVBAR
// ========================================

function initNavbarEffects() {
    const navbar = document.querySelector('.navbar');
    
    window.addEventListener('scroll', function() {
        if (window.scrollY > 50) {
            navbar.style.boxShadow = '0 5px 20px rgba(10, 126, 164, 0.3)';
        } else {
            navbar.style.boxShadow = '0 2px 10px rgba(10, 126, 164, 0.2)';
        }
    });
    
    // Highlight active nav link
    const navLinks = document.querySelectorAll('.navbar-nav .nav-link');
    navLinks.forEach(link => {
        link.addEventListener('click', function() {
            navLinks.forEach(l => l.classList.remove('active'));
            this.classList.add('active');
        });
    });
}

// ========================================
// SCROLL SUAVE
// ========================================

function initSmoothScroll() {
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });
}

// ========================================
// FUNÇÕES UTILITÁRIAS
// ========================================

// Compartilhamento Social
function shareOnSocial(platform) {
    const currentUrl = window.location.href;
    const title = document.title;
    
    let url;
    
    switch(platform) {
        case 'facebook':
            url = `https://www.facebook.com/sharer/sharer.php?u=${encodeURIComponent(currentUrl)}`;
            break;
        case 'twitter':
            url = `https://twitter.com/intent/tweet?url=${encodeURIComponent(currentUrl)}&text=${encodeURIComponent(title)}`;
            break;
        case 'whatsapp':
            url = `https://wa.me/?text=${encodeURIComponent(title + ' ' + currentUrl)}`;
            break;
    }
    
    if (url) {
        window.open(url, '_blank', 'width=600,height=400');
    }
}

// Copiar Link
function copyLink() {
    const link = window.location.href;
    navigator.clipboard.writeText(link).then(() => {
        showNotification('Link copiado para a área de transferência!');
    });
}

// Notificação Toast
function showNotification(message, type = 'success') {
    const notification = document.createElement('div');
    notification.className = `alert alert-${type}`;
    notification.style.cssText = `
        position: fixed;
        top: 20px;
        right: 20px;
        z-index: 9999;
        animation: slideIn 0.3s ease;
        max-width: 300px;
    `;
    notification.innerHTML = `
        <i class="fas fa-check-circle"></i> ${message}
    `;
    
    document.body.appendChild(notification);
    
    setTimeout(() => {
        notification.style.animation = 'slideOut 0.3s ease';
        setTimeout(() => notification.remove(), 300);
    }, 3000);
}

// ========================================
// FILTROS (OPCIONAL)
// ========================================

function filterCards(category) {
    const cards = document.querySelectorAll('.card-hover');
    
    cards.forEach(card => {
        const badge = card.querySelector('.badge');
        if (!category || badge.textContent.includes(category)) {
            card.style.display = 'block';
            card.style.animation = 'fadeIn 0.3s ease';
        } else {
            card.style.display = 'none';
        }
    });
}

// ========================================
// LIGHT BOX (PARA IMAGENS)
// ========================================

function initLightbox() {
    const images = document.querySelectorAll('img[data-lightbox]');
    
    images.forEach(img => {
        img.addEventListener('click', function() {
            const modal = document.createElement('div');
            modal.className = 'lightbox-modal';
            modal.style.cssText = `
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0,0,0,0.8);
                display: flex;
                align-items: center;
                justify-content: center;
                z-index: 9999;
                animation: fadeIn 0.3s ease;
            `;
            
            const imgElement = document.createElement('img');
            imgElement.src = this.src;
            imgElement.style.cssText = `
                max-width: 90%;
                max-height: 90%;
                border-radius: 10px;
                box-shadow: 0 10px 40px rgba(0,0,0,0.5);
            `;
            
            modal.appendChild(imgElement);
            modal.addEventListener('click', () => modal.remove());
            
            document.body.appendChild(modal);
        });
    });
}

// ========================================
// ANIMAÇÕES ADICIONAIS CSS
// ========================================

const style = document.createElement('style');
style.textContent = `
    @keyframes slideIn {
        from {
            transform: translateX(400px);
            opacity: 0;
        }
        to {
            transform: translateX(0);
            opacity: 1;
        }
    }
    
    @keyframes slideOut {
        from {
            transform: translateX(0);
            opacity: 1;
        }
        to {
            transform: translateX(400px);
            opacity: 0;
        }
    }
    
    .nav-link {
        position: relative;
    }
    
    .nav-link::after {
        content: '';
        position: absolute;
        bottom: -5px;
        left: 0;
        width: 0;
        height: 2px;
        background: #80deea;
        transition: width 0.3s ease;
    }
    
    .nav-link:hover::after,
    .nav-link.active::after {
        width: 100%;
    }
`;
document.head.appendChild(style);

// ========================================
// LAZY LOADING (IMAGENS)
// ========================================

function initLazyLoading() {
    if ('IntersectionObserver' in window) {
        const images = document.querySelectorAll('img[loading="lazy"]');
        const imageObserver = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.src = entry.target.dataset.src;
                    imageObserver.unobserve(entry.target);
                }
            });
        });
        
        images.forEach(img => imageObserver.observe(img));
    }
}

// Inicializar lazy loading
window.addEventListener('load', initLazyLoading);

// ========================================
// RETORNO AO TOPO
// ========================================

function initBackToTop() {
    const backToTop = document.createElement('button');
    backToTop.innerHTML = '<i class="fas fa-arrow-up"></i>';
    backToTop.style.cssText = `
        position: fixed;
        bottom: 20px;
        right: 20px;
        width: 50px;
        height: 50px;
        border-radius: 50%;
        background: linear-gradient(135deg, #0a7ea4 0%, #1fa3c5 100%);
        color: white;
        border: none;
        cursor: pointer;
        z-index: 999;
        display: none;
        align-items: center;
        justify-content: center;
        font-size: 1.2rem;
        transition: all 0.3s ease;
        box-shadow: 0 4px 12px rgba(10, 126, 164, 0.3);
    `;
    
    document.body.appendChild(backToTop);
    
    window.addEventListener('scroll', () => {
        if (window.scrollY > 300) {
            backToTop.style.display = 'flex';
        } else {
            backToTop.style.display = 'none';
        }
    });
    
    backToTop.addEventListener('click', () => {
        window.scrollTo({
            top: 0,
            behavior: 'smooth'
        });
    });
    
    backToTop.addEventListener('mouseenter', function() {
        this.style.transform = 'translateY(-5px)';
    });
    
    backToTop.addEventListener('mouseleave', function() {
        this.style.transform = 'translateY(0)';
    });
}

// Inicializar botão de retorno ao topo
window.addEventListener('load', initBackToTop);

// ========================================
// PRINT
// ========================================

window.addEventListener('beforeprint', function() {
    document.querySelectorAll('.navbar, footer').forEach(el => {
        el.style.display = 'none';
    });
});

window.addEventListener('afterprint', function() {
    document.querySelectorAll('.navbar, footer').forEach(el => {
        el.style.display = '';
    });
});
