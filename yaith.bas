'To-do:
' - Why does the left side of Dwarf Castle not work
' - Implement character switching patch (NPC looks for Pass to activate)
' - Include pass in key item shuffle; put a key item in Kainazzo sequence
' - Yang appears in Fabul if you become paladin without having done that sequence, blocks your way
' - Patch out buggy twin
' - Make sure you can get out of the underground somehow
' - Talking to Rubicant in Babil before beating Kainazzo halts progress


#include once "../ff4rom/ff4rom.bas"
#include once "../common/deck.bas"

function Flag(item_index as UByte) as UByte

 dim result as UByte
 
 select case item_index
  case adamant_item: result = 74
  case baron_key_item: result = 5
  case darkness_crystal_item: result = 64
  case earth_crystal_item: result = 35
  case luca_key_item: result = 58
  case magma_key_item: result = 43
  case package_item: result = 0
  case pan_item: result = 77
  case sand_ruby_item: result = 18
  case twin_harp_item: result = 36
  case crystal_item: result = 224
 end select
 
 return result

end function


function MessageInstruction(item_index as UByte) as Instruction

 dim result as Instruction
 
 select case item_index
  case adamant_item
   result.code = bank3_instruction
   result.parameters(1) = 179
  case baron_key_item
   result.code = bank1_low_instruction
   result.parameters(1) = 78
  case darkness_crystal_item
   result.code = bank1_high_instruction
   result.parameters(1) = 212
  case earth_crystal_item
   result.code = bank1_high_instruction
   result.parameters(1) = 186
  case luca_key_item
   result.code = bank1_high_instruction
   result.parameters(1) = 248
  case magma_key_item
   result.code = bank1_high_instruction
   result.parameters(1) = 11
  case package_item
   result.code = bank3_instruction
   result.parameters(1) = 180
  case pan_item
   result.code = bank3_instruction
   result.parameters(1) = 181
  case sand_ruby_item
   result.code = bank1_high_instruction
   result.parameters(1) = 137
  case twin_harp_item
   result.code = bank1_high_instruction
   result.parameters(1) = 190
  case crystal_item
   result.code = bank3_instruction
   result.parameters(1) = 117
 end select
 
 return result

end function


dim filename as String
dim ff4 as FF4Rom
dim seedinput as String

line input "Enter ROM file name: ", filename
'filename = "test.smc"

ff4.ReadFromFile(filename)

input "Enter seed (leave blank for random seed): ", seedinput

dim seed as UInteger
seed = iif(seedinput = "", timer, val(seedinput))

dim old_items as List
dim new_items as List
dim items_deck as Deck

''Actor starting equipment
'old_items.AddValue(legend_sword_item)

''Chest
'old_items.AddValue(rat_tail_item)

''Monster drop
'old_items.AddValue(tower_key_item)

'Shuffle the plot items
old_items.AddValue(adamant_item)
old_items.AddValue(baron_key_item)
old_items.AddValue(darkness_crystal_item)
old_items.AddValue(earth_crystal_item)
old_items.AddValue(luca_key_item)
old_items.AddValue(magma_key_item)
old_items.AddValue(package_item)
old_items.AddValue(pan_item)
old_items.AddValue(sand_ruby_item)
old_items.AddValue(twin_harp_item)
old_items.AddValue(crystal_item)

for i as Integer = 1 to old_items.Length()
 items_deck.AddCard(old_items.ItemAt(i))
next
items_deck.Shuffle()
do while items_deck.Size() > 0
 new_items.AddValue(val(items_deck.Draw()))
loop

dim entry as Instruction ptr
dim temp as UByte
dim dialog as Instruction
dim c as CallComponent ptr

'Reassign the new locations of the plot items
temp = new_items.ValueAt(old_items.IndexOfValue(adamant_item))
ff4.ChangeScriptEntry(trade_for_adamant_event, 8, gain_item_instruction, temp)
ff4.ChangeScriptEntry(trade_for_adamant_event, 5, MessageInstruction(temp))

temp = new_items.ValueAt(old_items.IndexOfValue(baron_key_item))
ff4.ChangeScriptEntry(yang_inn_event, 160, gain_item_instruction, temp)
ff4.ChangeScriptEntry(yang_inn_event, 159, MessageInstruction(temp))

temp = new_items.ValueAt(old_items.IndexOfValue(darkness_crystal_item))
ff4.ChangeScriptEntry(get_darkness_crystal_event, 1, gain_item_instruction, temp)
ff4.ChangeScriptEntry(get_darkness_crystal_event, 6, MessageInstruction(temp))

temp = new_items.ValueAt(old_items.IndexOfValue(earth_crystal_item))
ff4.ChangeScriptEntry(get_earth_crystal_event, 1, gain_item_instruction, temp)
ff4.ChangeScriptEntry(get_earth_crystal_event, 6, MessageInstruction(temp))

temp = new_items.ValueAt(old_items.IndexOfValue(luca_key_item))
ff4.ChangeScriptEntry(get_luca_key_event, 19, gain_item_instruction, temp)
ff4.ChangeScriptEntry(get_luca_key_event, 18, MessageInstruction(temp))

temp = new_items.ValueAt(old_items.IndexOfValue(magma_key_item))
ff4.ChangeScriptEntry(valvalis_battle_event, 223, gain_item_instruction, temp)
ff4.ChangeScriptEntry(valvalis_battle_event, 225, MessageInstruction(temp))

temp = new_items.ValueAt(old_items.IndexOfValue(package_item))
ff4.ChangeScriptEntry(opening_event, 511, gain_item_instruction, temp)
ff4.ChangeScriptEntry(opening_event, 510, MessageInstruction(temp))

temp = new_items.ValueAt(old_items.IndexOfValue(pan_item))
ff4.ChangeScriptEntry(get_pan_event, 17, gain_item_instruction, temp)
ff4.ChangeScriptEntry(get_pan_event, 16, MessageInstruction(temp))

temp = new_items.ValueAt(old_items.IndexOfValue(sand_ruby_item))
ff4.ChangeScriptEntry(antlion_battle_event, 60, gain_item_instruction, temp)
ff4.ChangeScriptEntry(antlion_battle_event, 59, MessageInstruction(temp))

temp = new_items.ValueAt(old_items.IndexOfValue(twin_harp_item))
ff4.ChangeScriptEntry(get_twin_harp_event, 85, gain_item_instruction, temp)
ff4.ChangeScriptEntry(get_twin_harp_event, 83, MessageInstruction(temp))

temp = new_items.ValueAt(old_items.IndexOfValue(crystal_item))
ff4.ChangeScriptEntry(ending_event, 319, gain_item_instruction, temp)
ff4.ChangeScriptEntry(ending_event, 321, MessageInstruction(temp))

ff4.bank3_messages(178).text = ff4.ConvertText("It's a rat tail I have") + chr(line_break_code) + ff4.ConvertText("been looking for!") + chr(line_break_code) + ff4.ConvertText("Okay! Take the ore!") + chr(message_end_code)
ff4.bank3_messages(179).text = ff4.ConvertText("Received Adamant!") + chr(song_code) + chr(41) + chr(pause_code) + chr(40) + chr(message_end_code)
entry = callocate(SizeOf(Instruction))
entry->code = bank3_instruction
entry->parameters(1) = 178
ff4.events(trade_for_adamant_event).script.InsertPointer(5, entry)

ff4.bank3_messages(180).text = ff4.ConvertText("Received the Package.") + chr(message_end_code)
ff4.bank3_messages(181).text = ff4.ConvertText("Received Frying Pan!") + chr(message_end_code)

'Fix the condition flags so they're looking for the right items

'Adamant: Get excalibur
c = ff4.npcs(366).speech.components.PointerAt(1)
c->false_conditions.AssignValue(1, Flag(old_items.ValueAt(new_items.IndexOfValue(adamant_item))))
'Baron Key: Locked doors in Baron
c = ff4.npcs(45).speech.components.PointerAt(1)
c->true_conditions.AssignValue(1, Flag(old_items.ValueAt(new_items.IndexOfValue(baron_key_item))))
c = ff4.npcs(46).speech.components.PointerAt(1)
c->true_conditions.AssignValue(1, Flag(old_items.ValueAt(new_items.IndexOfValue(baron_key_item))))
'Dark Crystal: Leaving sealed cave
c = ff4.eventcalls(72).components.PointerAt(1)
c->true_conditions.AssignValue(1, Flag(old_items.ValueAt(new_items.IndexOfValue(darkness_crystal_item))))
'Earth Crystal: Talking to clerics
c = ff4.eventcalls(44).components.PointerAt(1)
c->true_conditions.AssignValue(1, Flag(old_items.ValueAt(new_items.IndexOfValue(earth_crystal_item))))
'Luca Key: Entering sealed cave
entry = ff4.events(167).script.PointerAt(2)
entry->parameters(1) = old_items.ValueAt(new_items.IndexOfValue(luca_key_item))
'Magma Key: Well in Agart
c = ff4.npcs(139).speech.components.PointerAt(1)
c->true_conditions.AssignValue(1, Flag(old_items.ValueAt(new_items.IndexOfValue(magma_key_item))))
'Package: Mist
c = ff4.eventcalls(12).components.PointerAt(1)
c->true_conditions.AddValue(Flag(old_items.ValueAt(new_items.IndexOfValue(package_item))))
'Pan: Yang waking up
c = ff4.npcs(395).speech.components.PointerAt(2)
c->true_conditions.AssignValue(1, Flag(old_items.ValueAt(new_items.IndexOfValue(pan_item))))
'Sand Ruby: Rosa waking up
c = ff4.npcs(97).speech.components.PointerAt(1)
c->true_conditions.AssignValue(1, Flag(old_items.ValueAt(new_items.IndexOfValue(sand_ruby_item))))
'Twin Harp: Dark Elf battle
c = ff4.npcs(168).speech.components.PointerAt(1)
c->true_conditions.AssignValue(1, Flag(old_items.ValueAt(new_items.IndexOfValue(twin_harp_item))))
c = ff4.npcs(168).speech.components.PointerAt(2)
c->true_conditions.AssignValue(1, Flag(old_items.ValueAt(new_items.IndexOfValue(twin_harp_item))))
'Crystal: Zeromus
' I don't think anything needs to be done for this one

'Fix a bug with NPC speeches
' write 0x80 to 0x726b write 0xea to 0x7271 write 0xea to 0x7275
ff4.ApplyPatch(&h726B, chr(&h80))
ff4.ApplyPatch(&h7271, chr(&hEA))
ff4.ApplyPatch(&h7275, chr(&hEA))

'Shuffle all the chests
dim chest_deck as Deck
dim t as Trigger ptr
for i as Integer = 0 to total_maps
 for j as Integer = 1 to ff4.maps(i).triggers.Length()
  t = ff4.maps(i).triggers.PointerAt(j)
  if t->treasure and not t->gil then
   chest_deck.AddCard(chr(t->contents))
  end if
 next
next
chest_deck.AddCard(chr(black_sword_item))
chest_deck.AddCard(chr(crystal_sword_item))
chest_deck.AddCard(chr(masamune_item))
chest_deck.AddCard(chr(murasame_item))
chest_deck.AddCard(chr(white_spear_item))
chest_deck.AddCard(chr(excalibur_item))
chest_deck.AddCard(chr(adamant_armor_item))
chest_deck.AddCard(chr(spoon_item))
chest_deck.Shuffle()
for i as Integer = 0 to total_maps
 for j as Integer = 1 to ff4.maps(i).triggers.Length()
  t = ff4.maps(i).triggers.PointerAt(j)
  if t->treasure and not t->gil then
   t->contents = asc(chest_deck.Draw())
  end if
 next
next

dim text as String

entry = ff4.events(fabul_inn_event).script.PointerAt(50)
entry->parameters(1) = asc(chest_deck.Draw())
text = trim(right(ff4.DisplayText(ff4.items(entry->parameters(1)).name), 8)) + "!"
text = ff4.ConvertText("Received ") + left(ff4.items(entry->parameters(1)).name, 1) + ff4.ConvertText(text)
ff4.bank3_messages(182).text = text + chr(message_end_code)
entry = ff4.events(fabul_inn_event).script.PointerAt(52)
entry->code = bank3_instruction
entry->parameters(1) = 182

entry = ff4.events(crystal_sword_event).script.PointerAt(10)
entry->parameters(1) = asc(chest_deck.Draw())
text = trim(right(ff4.DisplayText(ff4.items(entry->parameters(1)).name), 8)) + "!"
text = ff4.ConvertText("Received ") + left(ff4.items(entry->parameters(1)).name, 1) + ff4.ConvertText(text)
ff4.bank3_messages(173).text = text + chr(message_end_code)
'ff4.bank3_messages(173).text = ff4.ConvertText("Received ") + ff4.items(entry->parameters(1)).name + chr(message_end_code)

entry = ff4.events(masamune_event).script.PointerAt(10)
entry->parameters(1) = asc(chest_deck.Draw())
text = trim(right(ff4.DisplayText(ff4.items(entry->parameters(1)).name), 8)) + "!"
text = ff4.ConvertText("Received ") + left(ff4.items(entry->parameters(1)).name, 1) + ff4.ConvertText(text)
ff4.bank3_messages(174).text = text + chr(message_end_code)
'ff4.bank3_messages(174).text = ff4.ConvertText("Received ") + ff4.items(entry->parameters(1)).name + chr(message_end_code)

entry = ff4.events(murasame_event).script.PointerAt(9)
entry->parameters(1) = asc(chest_deck.Draw())
text = trim(right(ff4.DisplayText(ff4.items(entry->parameters(1)).name), 8)) + "!"
text = ff4.ConvertText("Received ") + left(ff4.items(entry->parameters(1)).name, 1) + ff4.ConvertText(text)
ff4.bank3_messages(177).text = text + chr(message_end_code)
'ff4.bank3_messages(177).text = ff4.ConvertText("Received ") + ff4.items(entry->parameters(1)).name + chr(message_end_code)

entry = ff4.events(white_spear_event).script.PointerAt(10)
entry->parameters(1) = asc(chest_deck.Draw())
text = trim(right(ff4.DisplayText(ff4.items(entry->parameters(1)).name), 8)) + "!"
text = ff4.ConvertText("Received ") + left(ff4.items(entry->parameters(1)).name, 1) + ff4.ConvertText(text)
ff4.bank3_messages(176).text = text + chr(message_end_code)
'ff4.bank3_messages(176).text = ff4.ConvertText("Received ") + ff4.items(entry->parameters(1)).name + chr(message_end_code)

entry = ff4.events(excalibur_event).script.PointerAt(2)
entry->parameters(1) = asc(chest_deck.Draw())
text = trim(right(ff4.DisplayText(ff4.items(entry->parameters(1)).name), 8)) + "!"
text = ff4.ConvertText("Received ") + left(ff4.items(entry->parameters(1)).name, 1) + ff4.ConvertText(text)
text = ff4.ConvertText(trim(right(ff4.DisplayText(ff4.items(entry->parameters(1)).name), 8)) + "!") + chr(line_break_code) + chr(line_break_code) + text
text = ff4.ConvertText("It's done!") + chr(line_break_code) + ff4.ConvertText("Here is the sacred sword,") + chr(line_break_code) + text
ff4.bank3_messages(183).text = text + chr(message_end_code)
'ff4.bank3_messages(183).text = ff4.ConvertText("Received ") + ff4.items(entry->parameters(1)).name + chr(message_end_code)
entry = ff4.events(excalibur_event).script.PointerAt(1)
entry->code = bank3_instruction
entry->parameters(1) = 183

entry = ff4.events(adamant_armor_event).script.PointerAt(9)
entry->parameters(1) = asc(chest_deck.Draw())
text = trim(right(ff4.DisplayText(ff4.items(entry->parameters(1)).name), 8)) + "!"
text = ff4.ConvertText("Received ") + left(ff4.items(entry->parameters(1)).name, 1) + ff4.ConvertText(text)
text = ff4.ConvertText("Great!") + chr(line_break_code) + ff4.ConvertText("Take this too!") + chr(line_break_code) + text
text = ff4.ConvertText("Oh! Oh! Oh!") + chr(line_break_code) + ff4.ConvertText("Legendary Pink Tail!!") + chr(line_break_code) + text
ff4.bank3_messages(184).text = text + chr(message_end_code)
'ff4.bank3_messages(184).text = ff4.ConvertText("Received ") + ff4.items(entry->parameters(1)).name + chr(message_end_code)
entry = ff4.events(adamant_armor_event).script.PointerAt(7)
entry->code = bank3_instruction
entry->parameters(1) = 184

entry = ff4.events(spoon_event).script.PointerAt(4)
entry->parameters(1) = asc(chest_deck.Draw())
text = trim(right(ff4.DisplayText(ff4.items(entry->parameters(1)).name), 8)) + "!"
text = ff4.ConvertText("Received ") + left(ff4.items(entry->parameters(1)).name, 1) + ff4.ConvertText(text)
ff4.bank3_messages(185).text = text + chr(message_end_code)
'ff4.bank3_messages(185).text = ff4.ConvertText("Received ") + ff4.items(entry->parameters(1)).name + chr(message_end_code)
entry = ff4.events(spoon_event).script.PointerAt(6)
entry->code = bank3_instruction
entry->parameters(1) = 185

'Put an airship outside of baron
ff4.ChangeParameter(prologue_event, 155, 1, 28)

'Activate the hook
ff4.AddScriptEntry(prologue_event, set_flag_instruction, 54)

'Initialize the shadow party at the start of the game
ff4.AddScriptEntry(prologue_event, gain_actor_instruction, child_rydia_actor)
ff4.AddScriptEntry(prologue_event, lose_actor_instruction, child_rydia_actor)
ff4.AddScriptEntry(prologue_event, gain_actor_instruction, tellah1_actor)
ff4.AddScriptEntry(prologue_event, lose_actor_instruction, tellah1_actor)
ff4.AddScriptEntry(prologue_event, gain_actor_instruction, rosa1_actor)
ff4.AddScriptEntry(prologue_event, lose_actor_instruction, rosa1_actor)
ff4.AddScriptEntry(prologue_event, gain_actor_instruction, yang1_actor)
ff4.AddScriptEntry(prologue_event, lose_actor_instruction, yang1_actor)

'Put you on an airship after mist
ff4.ChangeParameter(mist_event, 165, 4, 4)

'Put you on an airship after fabul
ff4.ChangeParameter(fabul_ship_event, 606, 4, 4)

'Stop tied/sick Rosa from dis/appearing during "meanwhile"
ff4.events(meanwhile_event).script.RemoveIndex(195)
ff4.events(meanwhile_event).script.RemoveIndex(132)
ff4.events(kainazzo_event).script.RemoveIndex(430)
ff4.events(kainazzo_event).script.RemoveIndex(386)

dim event_list as List
'Excise all leader-changing instructions to prevent your guy from permanently
' becoming a pig or a mini or something
event_list = ff4.EventsContaining(set_leader_instruction)
for i as Integer = 1 to event_list.Length()
 for j as Integer = 1 to ff4.events(event_list.ValueAt(i)).script.Length()
  entry = ff4.events(event_list.ValueAt(i)).script.PointerAt(j)
  if entry->code = set_leader_instruction then
   entry->code = pause_code
   entry->parameters(1) = 1
  end if
 next
next

'Excise all solobattles
dim solobattles as Set
solobattles.AddValue(248)
solobattles.AddValue(249)
solobattles.AddValue(250)
solobattles.AddValue(242)
solobattles.AddValue(239)
solobattles.AddValue(247)
solobattles.AddValue(240)
solobattles.AddValue(241)
solobattles.AddValue(244)
solobattles.AddValue(254)
solobattles.AddValue(439 mod &h100)
solobattles.AddValue(236)
solobattles.AddValue(246)
solobattles.AddValue(436 mod &h100)
solobattles.AddValue(437 mod &h100)
event_list = ff4.EventsContaining(battle_instruction)
for i as Integer = 1 to event_list.Length()
 for j as Integer = 1 to ff4.events(event_list.ValueAt(i)).script.Length()
  entry = ff4.events(event_list.ValueAt(i)).script.PointerAt(j)
  if entry->code = battle_instruction then
   if solobattles.ContainsValue(entry->parameters(1) + 1) then
    entry->code = pause_instruction
    entry->parameters(1) = 1
   end if
  end if
 next
next

'Make zeromus battle not kill you if you don't have a paladin
ff4.events(ending_event).script.RemoveIndex(150)

'Set up Zeromus teleporter
' Hijack the "Obtain a Grimoire" event which appears to be unused in FF2US
dim parameter_list as List
ff4.ClearEventScript(grimoire_event)
ff4.AddScriptEntry(grimoire_event, play_song_instruction, 27)
ff4.AddScriptEntry(grimoire_event, teleport_instruction, 114, 15, 22, &h80)
' Make the Baron serpent road launch the event
ff4.eventcalls(6).components.Destroy()
c = callocate(SizeOf(CallComponent))
c->event_index = grimoire_event
ff4.eventcalls(6).components.AddPointer(c)

filename = left(filename, instrrev(filename, ".") - 1) + " (" + str(seed) + ")" + mid(filename, instrrev(filename, "."))
'ff4.WriteEventCalls()
'ff4.WriteEvents()
'ff4.SaveToFile(filename)

ff4.WriteToFile(filename)
'ff4.WriteToFile("z.smc")
