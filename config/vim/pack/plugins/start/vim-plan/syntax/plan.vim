if has('conceal')
  if &termencoding ==# "utf-8" || &encoding ==# "utf-8"
    let s:checkbox_unchecked = "⭕️"
    let s:checkbox_checked = "✅"
    let s:checkbox_canceled = "❎"
    let s:checkbox_migrated = "🔜"
  else
    let s:checkbox_unchecked = 'o'
    let s:checkbox_checked = 'x'
    let s:checkbox_canceled = "-"
    let s:checkbox_migrated = ">"
  endif

  syntax match markdownCheckbox "^\s*\([-\*] \[[ x\->]\]\|--\|++\) " contains=markdownCheckboxChecked,markdownCheckboxUnchecked,markdownCheckboxCanceled,markdownCheckboxMigrated
  execute 'syntax match markdownCheckboxUnchecked "\([-\*] \[ \]\|--\)" contained conceal cchar='.s:checkbox_unchecked
  execute 'syntax match markdownCheckboxChecked "\([-\*] \[x\]\|++\)" contained conceal cchar='.s:checkbox_checked
  execute 'syntax match markdownCheckboxCanceled "\([-\*] \[\-\]\|++\)" contained conceal cchar='.s:checkbox_canceled
  execute 'syntax match markdownCheckboxMigrated "\([-\*] \[>\]\|++\)" contained conceal cchar='.s:checkbox_migrated
endif

set conceallevel=2
