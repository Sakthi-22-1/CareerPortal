/* ============================================
   Smart Career Assessment Portal — JavaScript
   ============================================ */

// ——— DOM Ready ———
document.addEventListener('DOMContentLoaded', function () {
  initMobileNav();
  initQuizOptions();
  initDeleteConfirmation();
  initFormValidation();
  initSmoothScroll();
  initAnimateOnScroll();
});

/* ——— Mobile Navbar Toggle ——— */
function initMobileNav() {
  const hamburger = document.querySelector('.hamburger');
  const navLinks = document.querySelector('.navbar-links');

  if (hamburger && navLinks) {
    hamburger.addEventListener('click', function () {
      navLinks.classList.toggle('active');
      // Animate hamburger lines
      this.classList.toggle('open');
    });

    // Close menu when clicking a link
    navLinks.querySelectorAll('a').forEach(function (link) {
      link.addEventListener('click', function () {
        navLinks.classList.remove('active');
        hamburger.classList.remove('open');
      });
    });

    // Close menu on outside click
    document.addEventListener('click', function (e) {
      if (!hamburger.contains(e.target) && !navLinks.contains(e.target)) {
        navLinks.classList.remove('active');
        hamburger.classList.remove('open');
      }
    });
  }
}

/* ——— Form Validation ——— */
function initFormValidation() {
  var forms = document.querySelectorAll('form[data-validate]');
  forms.forEach(function (form) {
    form.addEventListener('submit', function (e) {
      var isValid = true;
      var inputs = form.querySelectorAll('input[required], textarea[required], select[required]');

      inputs.forEach(function (input) {
        removeFieldError(input);

        if (input.value.trim() === '') {
          isValid = false;
          showFieldError(input, 'This field is required');
        } else if (input.type === 'email' && !validateEmail(input.value)) {
          isValid = false;
          showFieldError(input, 'Please enter a valid email address');
        } else if (input.type === 'password' && input.value.length < 4) {
          isValid = false;
          showFieldError(input, 'Password must be at least 4 characters');
        }
      });

      if (!isValid) {
        e.preventDefault();
      }
    });
  });
}

function validateEmail(email) {
  var regex = /^[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}$/;
  return regex.test(email);
}

function showFieldError(input, message) {
  input.style.borderColor = '#c62828';
  var error = document.createElement('span');
  error.className = 'field-error';
  error.style.color = '#c62828';
  error.style.fontSize = '0.8rem';
  error.style.marginTop = '4px';
  error.style.display = 'block';
  error.textContent = message;
  input.parentNode.appendChild(error);
}

function removeFieldError(input) {
  input.style.borderColor = '';
  var errors = input.parentNode.querySelectorAll('.field-error');
  errors.forEach(function (err) { err.remove(); });
}

/* ——— Quiz Timer ——— */
var timerInterval = null;

function startQuizTimer(durationMinutes, displayElementId, formId) {
  var totalSeconds = durationMinutes * 60;
  var display = document.getElementById(displayElementId);
  var form = document.getElementById(formId);

  if (!display) return;

  timerInterval = setInterval(function () {
    var minutes = Math.floor(totalSeconds / 60);
    var seconds = totalSeconds % 60;

    display.textContent = String(minutes).padStart(2, '0') + ':' + String(seconds).padStart(2, '0');

    // Warning state when less than 60 seconds
    if (totalSeconds <= 60) {
      display.classList.add('timer-warning');
    }

    if (totalSeconds <= 0) {
      clearInterval(timerInterval);
      display.textContent = '00:00';
      // Auto-submit the quiz
      if (form) {
        showToast('Time\'s up! Submitting your quiz...', 'warning');
        setTimeout(function () {
          form.submit();
        }, 1000);
      }
    }

    totalSeconds--;
  }, 1000);
}

function stopQuizTimer() {
  if (timerInterval) {
    clearInterval(timerInterval);
  }
}

/* ——— Quiz Option Selection Highlight ——— */
function initQuizOptions() {
  var optionLabels = document.querySelectorAll('.quiz-option');

  optionLabels.forEach(function (label) {
    var radio = label.querySelector('input[type="radio"]');
    if (radio) {
      radio.addEventListener('change', function () {
        // Remove selected from sibling options
        var questionCard = label.closest('.quiz-question');
        if (questionCard) {
          questionCard.querySelectorAll('.quiz-option').forEach(function (opt) {
            opt.classList.remove('selected-option');
          });
        }
        label.classList.add('selected-option');
      });
    }
  });
}

/* ——— Delete Confirmation ——— */
function initDeleteConfirmation() {
  var deleteLinks = document.querySelectorAll('[data-confirm]');
  deleteLinks.forEach(function (link) {
    link.addEventListener('click', function (e) {
      var message = this.getAttribute('data-confirm') || 'Are you sure you want to delete this item?';
      if (!confirm(message)) {
        e.preventDefault();
      }
    });
  });
}

function confirmDelete(message) {
  return confirm(message || 'Are you sure you want to delete this item? This action cannot be undone.');
}

/* ——— Smooth Scroll ——— */
function initSmoothScroll() {
  var scrollLinks = document.querySelectorAll('a[href^="#"]');
  scrollLinks.forEach(function (link) {
    link.addEventListener('click', function (e) {
      var targetId = this.getAttribute('href');
      if (targetId && targetId !== '#') {
        var target = document.querySelector(targetId);
        if (target) {
          e.preventDefault();
          target.scrollIntoView({ behavior: 'smooth', block: 'start' });
        }
      }
    });
  });
}

/* ——— Animate on Scroll ——— */
function initAnimateOnScroll() {
  var animateElements = document.querySelectorAll('.animate-on-scroll');
  if (animateElements.length === 0) return;

  var observer = new IntersectionObserver(function (entries) {
    entries.forEach(function (entry) {
      if (entry.isIntersecting) {
        entry.target.classList.add('animate-slide');
        observer.unobserve(entry.target);
      }
    });
  }, { threshold: 0.1 });

  animateElements.forEach(function (el) { observer.observe(el); });
}

/* ——— Toast Notification ——— */
function showToast(message, type) {
  type = type || 'info';
  var toast = document.createElement('div');
  toast.className = 'alert alert-' + type;
  toast.style.position = 'fixed';
  toast.style.top = '80px';
  toast.style.right = '20px';
  toast.style.zIndex = '9999';
  toast.style.minWidth = '280px';
  toast.style.maxWidth = '400px';
  toast.style.boxShadow = '0 8px 30px rgba(0,0,0,0.15)';
  toast.textContent = message;

  document.body.appendChild(toast);

  setTimeout(function () {
    toast.style.transition = 'opacity 0.3s ease';
    toast.style.opacity = '0';
    setTimeout(function () { toast.remove(); }, 300);
  }, 3000);
}

/* ——— Admin: Populate Edit Form ——— */
function populateEditForm(id, category, question, optA, optB, optC, optD, correct, topic) {
  var form = document.getElementById('editForm') || document.getElementById('addQuestionForm');
  if (!form) return;

  // Try to set fields
  setFieldValue('editId', id);
  setFieldValue('category', category);
  setFieldValue('question', question);
  setFieldValue('optionA', optA);
  setFieldValue('optionB', optB);
  setFieldValue('optionC', optC);
  setFieldValue('optionD', optD);
  setFieldValue('correctOption', correct);
  setFieldValue('topic', topic);

  // Scroll to form
  form.scrollIntoView({ behavior: 'smooth', block: 'start' });

  // Change button text
  var submitBtn = form.querySelector('button[type="submit"]');
  if (submitBtn) {
    submitBtn.textContent = '✏️ Update Question';
  }

  // Change form action for update
  form.action = 'updateQuestion';
}

function setFieldValue(fieldId, value) {
  var field = document.getElementById(fieldId);
  if (field) {
    field.value = value || '';
  }
}

/* ——— Auto-dismiss alerts after 5 seconds ——— */
(function () {
  setTimeout(function () {
    var alerts = document.querySelectorAll('.alert:not([style*="position: fixed"])');
    alerts.forEach(function (alert) {
      alert.style.transition = 'opacity 0.3s ease, max-height 0.3s ease';
      alert.style.opacity = '0';
      alert.style.maxHeight = '0';
      alert.style.overflow = 'hidden';
      alert.style.padding = '0';
      alert.style.margin = '0';
      setTimeout(function () { alert.remove(); }, 300);
    });
  }, 5000);
})();
