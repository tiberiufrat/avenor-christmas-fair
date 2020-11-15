import Swal from 'sweetalert';
import Rails from '@rails/ujs';

window.Swal = Swal;

// Behavior after click to confirm button
const confirmed = (element, result) => {
  console.log('1')
  if (result) {
    console.log('2')
    if (!!element.getAttribute('data-remote')) {
      console.log('3')
      let reloadAfterSuccess = !!element.getAttribute('data-reload');
      console.log('ajax')
      $.ajax({
        method: element.getAttribute('data-method') || 'GET',
        url: element.getAttribute('href'),
        dataType: 'json',
        success: function(result) {
          console.log("success")
          Swal('Operațiune încheiată cu succes!', '', 'success')
              .then((_result) => {
                reloadWithTurbolinks()
              });
        },
        error: function(xhr) {
          console.log('error')
          let title   = 'Eroare!';
          let message = 'Am întâmpinat o eroare la completarea operațiunii. Încearcă din nou mai târziu.';

          if (xhr.responseJSON && xhr.responseJSON.message) {
            message = xhr.responseJSON.message;
          }

          Swal(title, message,'error');
        }
      });
    } else {
      element.removeAttribute('data-confirm-swal');
      element.click();
    }
  }
};

// Display the confirmation dialog
const showConfirmationDialog = (element) => {
  const message = element.getAttribute('data-confirm-swal');
  const text    = element.getAttribute('data-text-swal');
  const icon    = element.getAttribute('data-icon-swal');
  const ok = element.getAttribute('data-ok-swal')
  const cancel  = element.getAttribute('data-cancel-swal');

  Swal({
    title:             message || 'Ești sigur?',
    text:              text || '',
    icon:              icon || 'warning',
    buttons:           [cancel || 'Anulează', ok || 'Șterge'],
    dangerMode:        true,
  }).then(result => confirmed(element, result));
};

const allowAction = (element) => {
    if (element.getAttribute('data-confirm-swal') === null) {
        return true;
    }

    showConfirmationDialog(element);
    return false;
};

function handleConfirm(element) {
    if (!allowAction(this)) {
        Rails.stopEverything(element);
    }
}

Rails.delegate(document, 'a[data-confirm-swal]', 'click', handleConfirm);
