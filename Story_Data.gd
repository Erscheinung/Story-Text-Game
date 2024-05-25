extends Node

var story_nodes = {
	"start": {
		"text": "Here is where the story begins, make your first choice",
		"choices": [
			{"label": "Choose to Live", 									"target": "next1.1"},
			{"label": "Fall in despair and kill yourself",					"target": "next1.2"}
		]
	},
	"next1.1": {
		"text": "You Chose to live, now tell me: how does one live?",
		"choices": [
			{"label": "To live is to forget while pretending not to",		"target": "next2.1"},
			{"label": "To live is to know the truth but not tell it",		"target": "next2.1"}
		]
	},
	"next1.2": {
		"text": "You Chose to Die, why is that?",
		"choices": [
			{"label": "I can't see a way out, it's the only choice",		"target": "next2.2"},
			{"label": "I don't really know, but it seems right",			"target": "next2.2"}
		]
	},
	"next2.1": {
		"text": "Ok, but is that enough? What else?",
		"choices": [
			{"label": "No, I have hopes, dreams and things I want to do",	"target": "next3.1"},
			{"label": "I must live, it is better than the alternative",		"target": "next3.1"}
		]
	},
	"next2.2": {
		"text": "Can you remember a time when you were happy once?",
		"choices": [
			{"label": "Yes, but it's a distant memory, a time that no longer
			exists",														"target": "next3.2"},
			{"label": "I've always felt this way for as long as I can
			remember",														"target": "next3.2"}
		]
	}
}
