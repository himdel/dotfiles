// mod_autoindex to json
// document <- https://www.himdel.eu/miq/
// entries -> [{name: "2018-09-20T18:41:14Z.pass/", date: "2018-09-20 18:41", size: "-"},...]

const table = document.querySelector('table');
const [_header, _line, _parent, ...files] = table.querySelectorAll('tr');
const _line2 = files.pop();

function tdsToObj(acc, td, index) {
  if (index == 1) {
    acc.name = td.querySelector('a').innerText;
  } else if (index == 2) {
    acc.date = td.innerText;
  } else if (index == 3) {
    acc.size = td.innerText;
  }

  return acc;
}

const entries = files.map((tr) => {
  return Array.from(tr.querySelectorAll('td')).reduce(tdsToObj, {});
});
