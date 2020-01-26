// ==UserScript==
// @name        tts-fill
// @namespace   tts-fill
// @include     https://redhat.orangehrm.com/index.php/time/viewTimesheet/mode/my
// @version     16
// @grant       none
// @author      Daniel Mach <dmach@redhat.com>
// @author      Pavol Babincak <pbabinca@redhat.com>
// @author      Petr Machata <pmachata@redhat.com>
// @author      Karel Srot <ksrot@redhat.com>
// @author      Tomas Bzatek <tbzatek@redhat.com>
// @author      Marcel Kolaja <marcel.kolaja@redhat.com>
// @license     GPLv2
// ==/UserScript==

//In time as float number
var TIME_IN = 9;
//Break as float number
var TIME_BREAK = 0.5;
//Location where to navigate if TTS wasn't found
var LOCATION_TTS = 'https://redhat.orangehrm.com/index.php/time/viewTimesheet/mode/my';
//Variable which can be checked if this script was already loaded
var TTSFill = true;

var ACTIVE_ROW_QUERY = '#timesheetTable.timesheet_edit_table tr.activeRow:not(tr.days_off):not(tr.full_day_holiday)';

function isDayOff(node) {
    return node.hasClass('days_off');
}

function isHoliday(node) {
    return node.hasClass('full_day_holiday');
}

function isHalfDayLeave(node) {
    return node.hasClass('half_day_leave');
}

function fakeEnterValue(inputElement, value) {
    //Pretend to be human entering values so OrangeHRM JS time calculations
    //work properly.
    inputElement.click();
    inputElement.focus();
    inputElement.val(value);
    inputElement.blur();
}

function fillDay(rowElement) {
    // In Time
    var inTimeElement = rowElement.find('.timesheetTextCell[id*="inTime"]');
    // Out Time
    var outTimeElement = rowElement.find('.timesheetTextCell[id*="outTime"]');
    // Break Duration
    var breakDurationElement = rowElement.find('.timesheetTextCell[id*="breakDuration"]');

    //Any element not found
    if (!inTimeElement || !outTimeElement || !breakDurationElement) {
        return 0;
    }
    //Skip already filed values
    if (inTimeElement.val() || outTimeElement.val() || breakDurationElement.val()) {
        return 0;
    }
    fakeEnterValue(inTimeElement, $('#template_in_time').val());
    fakeEnterValue(outTimeElement, $('#template_out_time').val());
    fakeEnterValue(breakDurationElement, $('#template_break_duration').val());
    return 1
}

function processDay(element) {
    // skip weekends
    if (isDayOff(element)) {
        return 0;
    }

    // skip holidays
    if (isHoliday(element)) {
        return 0;
    }

    // skip half-day PTOs
    if (isHalfDayLeave(element)) {
        return 0;
    }

    // skip disabled fields (e.g. PTO)
    if (element.find('.timesheetTextCell:disabled').length > 0) {
        return 0;
    }

    fillDay(element);
}

function autoFill() {
    $(ACTIVE_ROW_QUERY).each(function(index, value) {
        processDay($(this));
    });
}


function splitDate(inTime)
{
    var outHours = Math.floor(inTime);
    var outMinutes = 60 * (inTime - outHours);

    var outHoursStr = outHours.toString();
    if (outHours < 10) {
        outHoursStr = '0' + outHours;
    }

    var outMinutesStr = outMinutes.toString();
    if (outMinutes < 10) {
        outMinutesStr = '0' + outMinutes;
    }

    return {
        'minutes': outMinutes,
        'hours': outHours,
        'minutes_str': outMinutesStr,
        'hours_str': outHoursStr,
    };
}

function installAutofill() {
    var totalDays = $(ACTIVE_ROW_QUERY).length;
    var expectedSplit = $('#expected').val().split(':');
    var expectedHours = parseInt(expectedSplit[0]);

    var thead = $('#timesheetTable thead');
    thead.append('<tr id="autofill_row">'
                   + '  <td class="timesheetDateCell2">&nbsp;</td>'
                   + '  <td>&nbsp;</td>'
                   + '  <td class="in_time_col">'
                   + '    <input type="text" title="Use 24 HR format"'
                   + '      id="template_in_time" alt="time" class="timesheetTextCell"'
                   + '      onkeypress="return restrictCharactersWithShiftKey(event)"'
                   + '      onkeydown="return restrictCharacters(this, event, allowChars);">'
                   + '    <div style="margin-left: 0px;padding-left: 0px;" class="errorContainer"></div>'
                   + '  </td>'
                     + '  <td class="out_time_col">'
                   + '    <input type="text" title="Use 24 HR format"'
                   + '      id="template_out_time" alt="time" class="timesheetTextCell"'
                   + '      onkeypress="return restrictCharactersWithShiftKey(event)"'
                   + '      onkeydown="return restrictCharacters(this, event, allowChars);">'
                   + '    <div style="margin-left: 0px;padding-left: 0px;" class="errorContainer"></div>'
                   + '  </td>'
                              + '  <td class="break_col">'
                   + '    <input type="text" title="Use 24 HR format"'
                   + '      id="template_break_duration" alt="duration" class="timesheetTextCell"'
                   + '      onkeypress="return restrictCharactersWithShiftKey(event)"'
                   + '      onkeydown="return restrictCharacters(this, event, allowChars);">'
                   + '    <div style="margin-left: 0px;padding-left: 0px;" class="errorContainer"></div>'
                   + '  </td>'

                   + '  <td class="medical_col">'
                   + '    <div style="margin-left: 0px;padding-left: 0px;" class="errorContainer"></div>'
                   + '  </td>'
                   + '  <td>&nbsp;</td>'
                   + '  <td class="tdTotalDuration">'
                   + '    <span id="template_span_row_total_duration" class="row_label"></span>'
                   + '  </td>'
                   + '  <td>&nbsp;</td>'
                   + '  <td colspan="2">'
                   + '    <input type="button" class="btn btn-xs rh-grn" value="Fill missing" id="btnAutoFill"'
                   + '      style="width: 140px !important;">'
                   + '  </td>'
                   + '</tr>');
        $('#btnAutoFill').bind('click', autoFill);
    $('#autofill_row td').css('background-color', '#DC9F2E');

    var inResult = splitDate(TIME_IN);
    var inTimeStr = inResult['hours_str'] + ':' + inResult['minutes_str'];
    $('#template_in_time').val(inTimeStr);

    var perDay = Math.floor(expectedHours / totalDays);
    var outTime = TIME_IN + perDay + (TIME_BREAK);

    var outResult = splitDate(outTime);
    var outTimeStr = outResult['hours_str'] + ':' + outResult['minutes_str'];
    $('#template_out_time').val(outTimeStr);

    if (perDay >= 8.0) {
        var breakResult = splitDate(TIME_BREAK);
        var breakTimeStr = breakResult['hours_str'] + ':' + breakResult['minutes_str'];
        $('#template_break_duration').val(breakTimeStr);
    }
}

function runTTSFill() {
    var timeSheetTableElement = document.getElementById('timesheetTable');
    if (timeSheetTableElement == null || timeSheetTableElement.value == '') {
        var frmLoginElement = document.getElementById('frmLogin');
        if (frmLoginElement != null) {
            window.alert('Please Log in. Bookmarklet cannot do that for you.');
            return;
        }

        if (window.location == LOCATION_TTS) {
            window.alert('Bookmarklet is broken: it cannot find table with timesheet forms even on correct page.');
        } else {
            window.location = LOCATION_TTS;
        }
        return;
    } else {
        if ($('#autofill_row').length == 0) {
            installAutofill();
        } else {
            autoFill();
        }
    }
}

(function () {
    runTTSFill();
})();
