# ## Audience Targeting
# For instance, a collaborators working on a shared project might perform multiple related activities in the process of achieving some goal. Such activities can be logically grouped together using the context property, and scoped to a particular audience using the audience property.
# {
#  "@context": "https://www.w3.org/ns/activitystreams",
#  "summary": "Activities in Project XYZ",
#  "type": "Collection",
#  "items": [
#    {
#      "summary": "Sally created a note",
#      "type": "Create",
#      "id": "http://activities.example.com/1",
#      "actor": "http://sally.example.org",
#      "object": {
#       "summary": "A note",
#        "type": "Note",
#        "id": "http://notes.example.com/1",
#        "content": "A note"
#      },
#      "context": {
#        "type": "http://example.org/Project",
#        "name": "Project XYZ"
#      },
#      "audience": {
#        "type": "Group",
#        "name": "Project XYZ Working Group"
#      },
#      "to": "http://john.example.org"
#    },
#    {
#      "summary": "John liked Sally's note",
#      "type": "Like",
#      "id": "http://activities.example.com/1",
#      "actor": "http://john.example.org",
#      "object": "http://notes.example.com/1",
#      "context": {
#        "type": "http://example.org/Project",
#        "name": "Project XYZ"
#      },
#      "audience": {
#        "type": "Group",
#        "name": "Project XYZ Working Group"
#      },
#      "to": "http://sally.example.org"
#    }
#  ]
# }
#
# ## Representing Relationships Between Entities
# The Relationship object is used to represent relationships between individuals. It can be used, for instance, to describe that one person is a friend of another, or that one person is a member of a particular organization. The intent of modeling Relationship in this way is to allow descriptions of activities that operate on the relationships in general, and to allow representation of Collections of relationships.
#
# For instance, many social systems have a notion of a "friends list". These are the collection of individuals that are directly connected within a person's social graph. Suppose we have a user, Sally, with direct relationships to users Joe and Jane. Sally follows Joe's updates while Sally and Jane have a mutual relationship.
# {
#   "@context": "https://www.w3.org/ns/activitystreams",
#   "summary": "Sally's friends list",
#   "type": "Collection",
#   "items": [
#     {
#       "summary": "Sally is influenced by Joe",
#       "type": "Relationship",
#       "subject": {
#         "type": "Person",
#         "name": "Sally"
#       },
#       "relationship": "http://purl.org/vocab/relationship/influencedBy",
#       "object": {
#         "type": "Person",
#         "name": "Joe"
#       }
#     },
#     {
#       "summary": "Sally is a friend of Jane",
#       "type": "Relationship",
#       "subject": {
#         "type": "Person",
#         "name": "Sally"
#       },
#       "relationship": "http://purl.org/vocab/relationship/friendOf",
#       "object": {
#         "type": "Person",
#         "name": "Jane"
#       }
#     }
#   ]
# }
#
# Modeling the relationship in this way allows implementers to articulate additional properties of the relationship itself. For instance, the date and time at which the relationship began or ended.
#
# {
#   "@context": "https://www.w3.org/ns/activitystreams",
#   "summary": "Sally became a friend of Matt",
#   "type": "Create",
#   "actor": "http://sally.example.org",
#   "object": {
#     "type": "Relationship",
#     "subject": "http://sally.example.org",
#     "relationship": "http://purl.org/vocab/relationship/friendOf",
#     "object": "http://matt.example.org",
#     "startTime": "2015-04-21T12:34:56"
#   }
# }
#
# The initial "friend request" can be modeled by composing the Offer and Relationship object types
# {
#   "@context": "https://www.w3.org/ns/activitystreams",
#   "id": "http://example.org/connection-requests/123",
#   "summary": "Sally requested to be a friend of John",
#   "type": "Offer",
#   "actor": "acct:sally@example.org",
#   "object": {
#     "summary": "Sally and John's friendship",
#     "id": "http://example.org/connections/123",
#     "type": "Relationship",
#     "subject": "acct:sally@example.org",
#     "relationship": "http://purl.org/vocab/relationship/friendOf",
#     "object": "acct:john@example.org"
#   },
#   "target": "acct:john@example.org"
# }
#
# Assuming the "friend request" is accepted, the remaining steps in this common application scenario can be represented as a set of distinct activities
# {
#   "@context": "https://www.w3.org/ns/activitystreams",
#   "summary": "Sally and John's relationship history",
#   "type": "Collection",
#   "items": [
#     {
#       "summary": "John accepted Sally's friend request",
#       "id": "http://example.org/activities/122",
#       "type": "Accept",
#       "actor": "acct:john@example.org",
#       "object": "http://example.org/connection-requests/123",
#       "inReplyTo": "http://example.org/connection-requests/123",
#       "context": "http://example.org/connections/123",
#       "result": [
#         "http://example.org/activities/123",
#         "http://example.org/activities/124",
#         "http://example.org/activities/125",
#         "http://example.org/activities/126"
#       ]
#     },
#     {
#       "summary": "John followed Sally",
#       "id": "http://example.org/activities/123",
#       "type": "Follow",
#       "actor": "acct:john@example.org",
#       "object": "acct:sally@example.org",
#       "context": "http://example.org/connections/123"
#     },
#     {
#       "summary": "Sally followed John",
#       "id": "http://example.org/activities/124",
#       "type": "Follow",
#       "actor": "acct:sally@example.org",
#       "object": "acct:john@example.org",
#       "context": "http://example.org/connections/123"
#     },
#     {
#       "summary": "John added Sally to his friends list",
#       "id": "http://example.org/activities/125",
#       "type": "Add",
#       "actor": "acct:john@example.org",
#       "object": "http://example.org/connections/123",
#       "target": {
#         "type": "Collection",
#         "summary": "John's Connections"
#       },
#       "context": "http://example.org/connections/123"
#     },
#     {
#       "summary": "Sally added John to her friends list",
#       "id": "http://example.org/activities/126",
#       "type": "Add",
#       "actor": "acct:sally@example.org",
#       "object": "http://example.org/connections/123",
#       "target": {
#         "type": "Collection",
#         "summary": "Sally's Connections"
#       },
#       "context": "http://example.org/connections/123"
#     }
#   ]
# }
#
# ## Representing Places
# The Place object is intentionally flexible. It can, for instance, be used to identify a location simply by name
# {
#   "@context": "https://www.w3.org/ns/activitystreams",
#   "type": "Place",
#   "name": "San Francisco, CA"
# }
#
# Or, by longitude and latitude:
# {
#   "@context": "https://www.w3.org/ns/activitystreams",
#   "type": "Place",
#   "name": "San Francisco, CA",
#   "longitude": "122.4167",
#   "latitude": "37.7833"
# }
#
#
# ## Representing Questions
# Simple open-ended questions similar to those posted to crowd-sourced question and answer websites:
# {
#   "@context": "https://www.w3.org/ns/activitystreams",
#   "name": "A question about robots",
#   "id": "http://help.example.org/question/1",
#   "type": "Question",
#   "content": "I'd like to build a robot to feed my cat. Should I use Arduino or Raspberry Pi?"
# }
#
# Multiple-choice questions or "polls" are also supported using either the oneOf or anyOf properties
# {
#   "@context": "https://www.w3.org/ns/activitystreams",
#   "id": "http://polls.example.org/question/1",
#   "name": "A question about robots",
#   "type": "Question",
#    "content": "I'd like to build a robot to feed my cat. Which platform is best?",
#    "oneOf": [
#      {"name": "arduino"},
#      {"name": "raspberry pi"}
#    ]
#  }
#
# Responses to questions are expressed as Objects containing an inReplyto property referencing the Question.
#  {
#  "@context": "https://www.w3.org/ns/activitystreams",
#  "attributedTo": "http://sally.example.org",
#  "inReplyTo": "http://polls.example.org/question/1",
#  "name": "arduino"
# }
#
# Because Question objects are also instances of Activity, the result property can be used to express the results or outcome of the Question (as appropriate):
# {
#   "@context": "https://www.w3.org/ns/activitystreams",
#   "name": "A question about robots",
#   "id": "http://polls.example.org/question/1",
#   "type": "Question",
#    "content": "I'd like to build a robot to feed my cat. Which platform is best?",
#    "oneOf": [
#      {"name": "arduino"},
#      {"name": "raspberry pi"}
#    ],
#    "replies": {
#      "type": "Collection",
#      "totalItems": 3,
#      "items": [
#        {
#          "attributedTo": "http://sally.example.org",
#          "inReplyTo": "http://polls.example.org/question/1",
#          "name": "arduino"
#        },
#        {
#          "attributedTo": "http://joe.example.org",
#          "inReplyTo": "http://polls.example.org/question/1",
#          "name": "arduino"
#        },
#        {
#          "attributedTo": "http://john.example.org",
#          "inReplyTo": "http://polls.example.org/question/1",
#          "name": "raspberry pi"
#        }
#      ]
#    },
#    "result": {
#      "type": "Note",
#      "content": "Users are favoriting &quot;arduino&quot; by a 33% margin."
#    }
#  }
#
# ## Inverse Activities and "Undo"
# Several of the core Activity types are defined as natural inversions of one another. These include:
#
# Accept and Reject,
# Arrive and Leave,
# Join and Leave,
# Create and Delete,
# Like and Dislike
#
# It is important to note that these types of activities are semantically distinct from one another and have no direct relationship on the other. That is, for example, if an actor "likes" a note at one point in time then later "dislikes" it, the "dislike" activity does not "undo" or negate out the prior "like".
#
# The appropriate interpretation for the following is that Sally first liked, then later disliked John\'s note
#
# {
#   "@context": "https://www.w3.org/ns/activitystreams",
#   "summary": "History of John's note",
#   "type": "Collection",
#   "items": [
#     {
#       "summary": "Sally liked John's note",
#       "type": "Like",
#       "actor": "http://sally.example.org",
#       "id": "http://activities.example.com/1",
#       "published": "2015-11-12T12:34:56Z",
#       "object": {
#         "summary": "John's note",
#         "type": "Note",
#         "id": "http://notes.example.com/1",
#         "attributedTo": "http://john.example.org",
#         "content": "My note"
#       }
#     },
#     {
#       "summary": "Sally disliked John's note",
#       "type": "Dislike",
#       "actor": "http://sally.example.org",
#       "id": "http://activities.example.com/2",
#       "published": "2015-12-11T21:43:56Z",
#       "object": {
#         "summary": "John's note",
#         "type": "Note",
#         "id": "http://notes.example.com/1",
#         "attributedTo": "http://john.example.org",
#         "content": "My note"
#       }
#     }
#   ]
#  }
#
#  The Undo activity type is defined to provide the specific ability to undo or cancel out a prior activity. The appropriate interpretation for the following, then, is that Sally liked John's note at one point but has explicitly redacted that like later on.
#  {
#  "@context": "https://www.w3.org/ns/activitystreams",
#  "summary": "History of John's note",
#  "type": "Collection",
#  "items": [
#    {
#      "summary": "Sally liked John's note",
#      "type": "Like",
#      "id": "http://activities.example.com/1",
#      "actor": "http://sally.example.org",
#      "published": "2015-11-12T12:34:56Z",
#      "object": {
#        "summary": "John's note",
#        "type": "Note",
#        "id": "http://notes.example.com/1",
#        "attributedTo": "http://john.example.org",
#        "content": "My note"
#      }
#    },
#    {
#      "summary": "Sally no longer likes John's note",
#      "type": "Undo",
#      "id": "http://activities.example.com/2",
#      "actor": "http://sally.example.org",
#      "published": "2015-12-11T21:43:56Z",
#      "object": "http://activities.example.com/1"
#    }
#  ]
# }
#
#
# Mentions, Tags and Other Common Social Microsyntaxes
#
# A typical social software implementation would typically render such a content such that "@sally" is replaced with a hyperlink to "@sally"'s social profile page and "#givingthanks" is replaced with a hyperlink to a listing of other notes that have been "tagged" with the same topic. Most implementations would also send a special notification to sally letting her know that a note mentioning her has been created.
# The to property indicates that the user "@sally" is to be considered part of the primary audience of the note and should therefore receive notification. The tag property associates the Note with a reference to " http://example.org/tags/givingthanks". Note that the content still includes the "@sally" and " #givingthanks" microsyntaxes but that consuming implementations are not required to parse those in order to make the appropriate associations.
# {
#   "@context": "https://www.w3.org/ns/activitystreams",
#   "name": "A thank-you note",
#   "type": "Note",
#   "content": "Thank you <a href='http://sally.example.org'>@sally</a>
#       for all your hard work!
#       <a href='http://example.org/tags/givingthanks'>#givingthanks</a>",
#   "to": {
#     "name": "Sally",
#     "type": "Person",
#     "id": "http://sally.example.org"
#   },
#   "tag": {
#     "id": "http://example.org/tags/givingthanks",
#     "name": "#givingthanks"
#   }
# }
#
# In the case a publisher wishes to indicate a mention without an associated notification, the publisher can use the Mention object type as a value of the tag property.
# {
#   "@context": "https://www.w3.org/ns/activitystreams",
#   "name": "A thank-you note",
#   "type": "Note",
#   "content": "Thank you @sally for all your hard work! #givingthanks",
#   "tag": [
#     {
#       "type": "Mention",
#       "href": "http://example.org/people/sally",
#       "name": "@sally"
#     },
#     {
#       "id": "http://example.org/tags/givingthanks",
#       "name": "#givingthanks"
#     }
#   ]
# }
#
#
# ## Origin and Target
# The origin and target properties of an Activity respectively identify the entities from which and to which the action is directed. For instance, in the English statement, "Sally moved the file from Folder A to Folder B", the origin is "Folder A" and the target is "Folder B".
#
# {
#     "@context": "https://www.w3.org/ns/activitystreams",
#     "summary": "Sally moved the sales figures from Folder A to Folder B",
#     "type": "Move",
#     "actor": "http://sally.example.org",
#     "object": {
#       "type": "Document",
#       "name": "sales figures"
#     },
#     "origin": {
#       "type": "Collection",
#       "name": "Folder A"
#     },
#     "target": {
#       "type": "Collection",
#       "name": "Folder B"
#     }
#   }
