document.addEventListener('turbolinks:load', function () {
  document.querySelectorAll('td').forEach(function(td) {
    td.addEventListener('mouseover', function (event) {
      event.currentTarget.style.backgroundColor = '#eff';
    });

    td.addEventListener('mouseout', function (event) {
      event.currentTarget.style.backgroundColor = '';
    })
  });
})

