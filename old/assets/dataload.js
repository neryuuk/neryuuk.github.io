(function ({ $, location }) {
  function lang() {
    const OPTIONS = { 'en-us': 'en-us', 'en': 'en-us', 'pt-br': 'pt-br', 'pt': 'pt-br' };
    const search = (new URLSearchParams(location.search.toLowerCase())).get('lang');
    return ((!!search) && OPTIONS[search]) || 'en-us';
  }

  function remoteLang(lang) {
    return ({ 'en-us': 'Remote', 'pt-br': 'Remoto' })[lang];
  }

  function formatDate({ year, month }) {
    return new Date(year, month - 1)
      .toLocaleString(LANG, { month: 'long', year: 'numeric' })
      .toLowerCase()
  }

  function range({ start, end }) {
    const present = { 'pt-br': 'presente', 'en-us': 'present' };
    return `${formatDate(start)} — ${end ? formatDate(end) : present[LANG]}`;
  }

  function paragraph(line) {
    return $('<p>').text(line);
  }

  function block(title, place, location, period, description) {
    let description_array = [];
    if (Array.isArray(description) && description.length) {
      description_array = description
    } else if (description) {
      description_array = [description]
    }

    return $('<span>').append(
      $('<h3>').text(title),
      $('<h4>').append(
        paragraph(`${place}, `).text(),
        $('<i class="fa-solid fa-location-dot location-dot-small">'),
        paragraph(` ${location}`).text()
      ),
      $('<p class="dates">').text(range(period)),
      ...description_array.map(paragraph)
    );
  }

  function employment(input) {
    return block(
      input.position,
      input.company.short_name,
      input.remote ? REMOTE : input.location,
      input.period,
      input.long_description
    );
  }

  function section(id, content) {
    const SECTIONS = {
      'profile': {
        name: { 'en-us': 'Profile', 'pt-br': 'Perfil' },
        mapper: paragraph,
      }, 'work-experience': {
        name: { 'en-us': 'Work Experience', 'pt-br': 'Experiências' },
        mapper: employment,
      }, 'education': {
        name: { 'en-us': 'Education', 'pt-br': 'Formação' },
        mapper: input => block(
          input.school.name,
          input.school.location,
          input.course,
          input.period,
          input.description
        ),
      }, 'internships': {
        name: { 'en-us': 'Internships and other experiences', 'pt-br': 'Estágios e outras experiências' },
        mapper: employment,
      },
    };
    const select = SECTIONS[id]

    return $(`#${id}`).replaceWith($('<section>').append(
      $('<h2>').text(select.name[LANG]),
      ...content.map(select.mapper)
    ));
  }

  const LANG = lang();
  const REMOTE = remoteLang(LANG);
  $.ajax({
    dataType: 'json',
    url: `/${LANG}.json`,
    success: ({ details, employment, education, internships }) => {
      if (details?.name) {
        $('#name').text(details?.name);
      }

      if (details?.title) {
        $('#title').text(details?.title);
      }

      if (Array.isArray(details?.profile) && details.profile.length > 0) {
        section('profile', details.profile);
      }

      if (Array.isArray(employment) && employment.length > 0) {
        section('work-experience', employment);
      }

      if (Array.isArray(education) && education.length > 0) {
        section('education', education);
      }

      if (Array.isArray(internships) && internships.length > 0) {
        section('internships', internships);
      }
    },
  });
})(window)
