# ## An extended activity
#
# {
#   "@context": "https://www.w3.org/ns/activitystreams",
#   "summary": "Martin's recent activities",
#   "type": "Collection",
#   "totalItems": 1,
#   "items" : [
#     {
#       "type": "Add",
#       "published": "2011-02-10T15:04:55Z",
#       "generator": "http://example.org/activities-app",
#       "nameMap": {
#         "en": "Martin added a new image to his album.",
#         "ga": "Martin phost le fisean nua a albam."
#       },
#       "actor": {
#         "type": "Person",
#         "id": "http://www.test.example/martin",
#         "name": "Martin Smith",
#         "url": "http://example.org/martin",
#         "image": {
#           "type": "Link",
#           "href": "http://example.org/martin/image",
#           "mediaType": "image/jpeg",
#           "width": 250,
#           "height": 250
#         }
#       },
#       "object" : {
#         "name": "My fluffy cat",
#         "type": "Image",
#         "id": "http://example.org/album/máiréad.jpg",
#         "preview": {
#           "type": "Link",
#           "href": "http://example.org/album/máiréad.jpg",
#           "mediaType": "image/jpeg"
#         },
#         "url": [
#           {
#             "type": "Link",
#             "href": "http://example.org/album/máiréad.jpg",
#             "mediaType": "image/jpeg"
#           },
#           {
#             "type": "Link",
#             "href": "http://example.org/album/máiréad.png",
#             "mediaType": "image/png"
#           }
#         ]
#       },
#       "target": {
#         "type": "Collection",
#         "id": "http://example.org/album/",
#         "nameMap": {
#           "en": "Martin's Photo Album",
#           "ga": "Grianghraif Mairtin"
#         },
#         "image": {
#           "type": "Link",
#           "href": "http://example.org/album/thumbnail.jpg",
#           "mediaType": "image/jpeg"
#         }
#       }
#     }
#   ]
# }
#
# ## Object
# Object that uses the id and type properties to express the global identifier and object type
# {
#   "@context": "https://www.w3.org/ns/activitystreams",
#   "id": "http://example.org/foo",
#   "type": "Note",
#   "name": "My favourite stew recipe",
#   "attributedTo": {
#     "id": "http://joe.website.example/",
#     "type": "Person",
#     "name": "Joe Smith"
#   },
#   "published": "2014-08-21T12:34:56Z"
# }
#
# Extension An Object that is both a Place and a gr:Location
# {
#   "@context": [
#     "https://www.w3.org/ns/activitystreams",
#     {
#       "gr": "http://purl.org/goodrelations/v1#"
#     }
#   ],
#   "type": ["Place", "gr:Location"],
#   "name": "Sally's Restaurant",
#   "longitude": 12.34,
#   "latitude": 56.78,
#   "gr:category": "restaurants/french_restaurants"
# }
#
# ### Text representations of Object types
# A note with a name defined by the author
# {
#   "@context": "https://www.w3.org/ns/activitystreams",
#   "type": "Note",
#   "id": "http://example.org/note/123",
#   "name": "Our Weather Is Fine",
#   "content": "I feel that the weather is appropriate to our season and location."
# }
#
# A note with an automatically-generated summary
# {
#   "@context": "https://www.w3.org/ns/activitystreams",
#   "type": "Note",
#   "id": "http://example.org/note/124",
#   "summary": "A note by Sally",
#   "content": "Everything is OK here."
# }
#
#
# ## Link
#
# To reference a single image without any additional metadata, a direct association can be expressed as a JSON string containing an absolute IRI.
# {
#   "@context": "https://www.w3.org/ns/activitystreams",
#   "type": "Application",
#   "id": "http://example.org/application/123",
#   "name": "Exampletron 3000",
#   "image": "http://example.org/application/123.png"
# }
#
# Alternatively, if additional metadata is required (such as the MIME content type of the referenced resource) a Link can be used:
# {
#   "@context": "https://www.w3.org/ns/activitystreams",
#   "type": "Application",
#   "id": "http://example.org/application/123",
#   "name": "Exampletron 3000",
#   "image": {
#     "type": "Link",
#     "href": "http://example.org/application/123.png",
#     "mediaType": "image/png"
#   }
# }
#
#  If more than one value is to be expressed, A JSON Array with a mix of strings and Links can be used
#  Individual items contained in such an array are independent of one another and no significance is given to the ordering.
#  {
#   "@context": "https://www.w3.org/ns/activitystreams",
#   "type": "Application",
#   "id": "http://example.org/application/123",
#   "name": "Exampletron 3000",
#   "image": [
#     "http://example.org/application/abc.gif",
#     {
#       "type": "Link",
#       "href": "http://example.org/application/123.png",
#       "mediaType": "image/png"
#     }
#   ]
# }
#
# RFC 5988 defines that all Links have a "link relation" that describes the contextual purpose of the link. Within a Link, the rel property provides the link relation value. If no rel property is specified, the link relation is considered to be unspecified. Any given Link can have multiple link relation values. In the JSON serialization, a single link relation is expressed as a single JSON string. Multiple link relations are expressed as an array of JSON strings.
#
# The scope of the link relation is the object in which the Link is an immediate child.
#
# In the following example, two separate references are provided. The link relation of the first is unspecified, while the link relation of the second is "thumbnail".
#
# {
#   "@context": "https://www.w3.org/ns/activitystreams",
#   "type": "Application",
#   "id": "http://example.org/application/123",
#   "name": "Exampletron 3000",
#   "image": [
#     "http://example.org/application/abc.gif",
#     {
#       "type": "Link",
#       "href": "http://example.org/application/123.png",
#       "mediaType": "image/png",
#       "rel": "thumbnail"
#     }
#   ]
# }
#
# ## Actor
# An Activity with a Person actor extended with VCard properties
# {
#   "@context": [
#     "https://www.w3.org/ns/activitystreams",
#     {"vcard": "http://www.w3.org/2006/vcard/ns#"}
#   ],
#   "summary": "Sally created a note",
#   "type": "Create",
#   "actor": {
#     "type": ["Person", "vcard:Individual"],
#     "id": "http://sally.example.org",
#     "name": "Sally Smith",
#     "vcard:given-name": "Sally",
#     "vcard:family-name": "Smith"
#   },
#   "object": {
#     "type": "Note",
#     "content": "This is a simple note"
#   }
# }
#
# ## Activity
# The following example illustrates a simple Activity:
# {
#   "@context": "https://www.w3.org/ns/activitystreams",
#   "summary": "Joe liked a note",
#   "type": "Like",
#   "id": "http://www.test.example/activity/1",
#   "actor": "http://example.org/profiles/joe",
#   "object": "http://example.com/notes/1",
#   "published": "2014-09-30T12:34:56Z"
# }
#
# An Activity that is both a Like and a http://schema.org/LikeAction
# {
#   "@context": "https://www.w3.org/ns/activitystreams",
#   "summary": "Joe liked a note",
#   "type": ["Like", "http://schema.org/LikeAction"],
#   "id": "http://www.test.example/activity/1",
#   "actor": "http://example.org/profiles/joe",
#   "object": "http://example.com/notes/1",
#   "published": "2014-09-30T12:34:56Z"
# }
#
# ## Collection
# The following is a simple unordered collection:
# {
#   "@context": "https://www.w3.org/ns/activitystreams",
#   "summary": "Object history",
#   "type": "Collection",
#   "totalItems": 2,
#   "items": [
#     {
#       "type": "Create",
#       "actor": "http://www.test.example/sally",
#       "object": "http://example.org/foo"
#     },
#     {
#       "type": "Like",
#       "actor": "http://www.test.example/joe",
#       "object": "http://example.org/foo"
#     }
#   ]
# }
#
# The following is a simple ordered collection
# {
#   "@context": "https://www.w3.org/ns/activitystreams",
#   "summary": "Object history",
#   "type": "OrderedCollection",
#   "totalItems": 2,
#   "orderedItems": [
#     {
#       "type": "Create",
#       "actor": "http://www.test.example/sally",
#       "object": "http://example.org/foo"
#     },
#     {
#       "type": "Like",
#       "actor": "http://www.test.example/joe",
#       "object": "http://example.org/foo"
#     }
#   ]
# }
#
# Collection Paging
# The following is a simple unordered collection with paging
# {
#   "@context": "https://www.w3.org/ns/activitystreams",
#   "summary": "Sally's recent activities",
#   "type": "Collection",
#   "id": "http://example.org/foo",
#   "totalItems": 10,
#   "first": {
#     "type": "CollectionPage",
#     "id": "http://example.org/foo?page=1",
#     "partOf": "http://example.org/foo",
#     "next": "http://example.org/foo?page=2",
#     "items": [
#       {
#         "type": "Create",
#         "actor": "http://www.test.example/sally",
#         "object": "http://example.org/foo"
#       }
#     ]
#   }
# }
#
# ## Natural Language Values
# A single name String value without language information
# {
#   "@context": "https://www.w3.org/ns/activitystreams",
#   "type": "Object",
#   "name": "This is the title"
# }
#
# Multiple, language-specific values
# Every key in the object form must be a well-formed [BCP47] Language-Tag. The associated values must be strings.
#
# The Activity Vocabulary defines three properties that use natural language values: name, summary, and content. Accordingly, in the JSON serialization, the terms " name", "summary", and "content" represent the JSON string forms; and the terms " nameMap", "summaryMap", and " contentMap" for represent the object forms.
# {
#   "@context": "https://www.w3.org/ns/activitystreams",
#   "type": "Object",
#   "nameMap": {
#     "en": "This is the title",
#     "fr": "C'est le titre",
#     "es": "Este es el título"
#   }
# }
#
# The special language tag "und" can be used within the object form to explicitly identify a value whose language is unknown or undetermined.
# {
#   "@context": "https://www.w3.org/ns/activitystreams",
#   "type": "Object",
#   "nameMap": {
#     "und": "This is the title"
#   }
# }
#
# Default Language Context
# Specifying the default "@language" within the JSON-LD @context
# {
#   "@context": [
#     "https://www.w3.org/ns/activitystreams",
#     {
#       "@language": "en"
#     }],
#   "type": "Object",
#   "name": "This is the title"
# }
