/mob/living/carbon/alien/say(message)

	if (silent)
		return

	message = sanitize_plus(copytext(message, 1, MAX_MESSAGE_LEN))

	if (length(message) >= 2)
		if (department_radio_keys[copytext(message, 1, 3)] == "alientalk")
			message = copytext(message, 3)
			message = trim(message)
			if (stat == DEAD)
				return say_dead(message)
			else
				alien_talk(message)
		else
			if (copytext(message, 1, 2) != "*" && !stat)
				playsound(loc, "hiss", 25, 1, 1)//So aliens can hiss while they hiss yo/N
			return ..(message, sanitize = 0)

/mob/living/carbon/alien/facehugger/say(message)

	if (silent)
		return

	message = sanitize_plus(copytext(message, 1, MAX_MESSAGE_LEN))

	if (length(message) >= 2)
		if (department_radio_keys[copytext(message, 1, 3)] == "alientalk")
			message = copytext(message, 3)
			message = trim(message)
			if (stat == DEAD)
				return say_dead(message)
			else
				alien_talk(message)

/mob/living/carbon/alien/larva/say(message)

	if (silent)
		return

	message = sanitize_plus(copytext(message, 1, MAX_MESSAGE_LEN))

	if (length(message) >= 2)
		if (department_radio_keys[copytext(message, 1, 3)] == "alientalk")
			message = copytext(message, 3)
			message = trim(message)
			if (stat == DEAD)
				return say_dead(message)
			else
				alien_talk(message)

/mob/living/proc/alien_talk(message)

	log_say("[key_name(src)] : [message]")
	message = trim(message)

	if (!message)
		return

	//var/message_a = sanitize_plus_chat(say_quote(message))
	//�� ��� ����� ����������, ����� �������� ��� ����� ����. � ����, ���
	var/message_a = "<span class='say_quote'>hisses,</span> \"<span class='body'>[sanitize_plus_chat(message)]</span>\""

	var/rendered = "<i><span class='game say'>Hivemind, <span class='name'>[name]</span> <span class='message'>[message_a]</span></span></i>"
	for (var/mob/living/S in player_list)
		if(!S.stat)
			if(S.alien_talk_understand)
				if(S.alien_talk_understand == alien_talk_understand)
					S.show_message(rendered, 2)
			else if (S.hivecheck())
				S.show_message(rendered, 2)

	var/list/listening = hearers(1, src)
	listening -= src
	listening += src

	var/list/heard = list()
	for (var/mob/M in listening)
		if(!isalien(M) && !M.alien_talk_understand)
			heard += M


	if (length(heard))
		var/message_b

		//message_b = "hsssss"
		//message_b = say_quote(message_b)
		message_b = "<span class='say_quote'>hisses,</span> \"<span class='body'>hsssss</span>\""

		message_b = "<i>[message_b]</i>"
		rendered = "<i><span class='game say'><span class='name'>[voice_name]</span> <span class='message'>[message_b]</span></span></i>"

		for (var/mob/M in heard)
			M.show_message(rendered, 2)

	//message = say_quote(message)
	message = "<span class='say_quote'>hisses,</span> \"<span class='body'>[message]</span>\""

	rendered = "<i><span class='game say'>Hivemind, <span class='name'>[name]</span> <span class='message'>[message_a]</span></span></i>"

	for (var/mob/M in player_list)
		if (isnewplayer(M))
			continue
		if (M.stat > 1)
			M.show_message(rendered, 2)
