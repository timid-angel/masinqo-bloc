# Masinko - a REST API for a music retail service
**Final project for Web Programming**

## Group Members - Section 1

- Lidiya Mamo Kibret - **UGR/2485/14**   |   _Lidiya-MK_
- Mati Milkessa Ensermu - **UGR/0949/14**   |   _RealMati_
- Natanim Kemal Abdela - **UGR/4648/14**   |   _Natanim-Kemal_
- Nathan Mesfin Shiferaw - **UGR/0534/14**   |   _timid-angel_

### Description
Masinko is a web-based music-sharing platform where artists can upload their works to a public platform where tracks are downloaded and rated by a general audience. The platform is motivated by the current musical atmosphere in which big streaming platforms continue to rise while pushing the most established musicians and bands without making special provisions for underground/local scenes. Music is a big part of culture, and we believe that the general trend toward Western
ideologies should not belittle the identity of any nation. This platform aims to uplift the discoverability of independent Ethiopian artists so that they may openly release their works to a platform that provides an even playing field regardless of their popularity or past achievements.
### Role Based CRUD and API Operations Summary

Artists:
- Create an account/ login with an existing account
- Create albums with their own album arts
- Access those albums to add songs
- Update the details of an album after its creation
- Delete pre-existing albums

Admins:
- Access the list of artists in the system
- Update artist information, including login credentials
- Delete artist accounts and all their created albums and songs


### Why MongoDB? A justification for using a Non-Relational Database for this Project
There are many quirks that lead us to the decision of using MongoDB. The powerful Mongoose ORM library is among them, but the primary reason lies in the way non-relational databases work and how responsive they are to changes. Due to SQL's rigid schema structure, it is hard to accommodate a flexible database. This project, dealing with albums, album arts and audio files, benefits from having flexibility in its schema definitions as there will inevitable be cases where a certain input field is omitted and must be replaced by a placeholder. With MongoDB and Mongoose, it is even possible to leave certain key fields empty and handle them when they are trying to be accessed. Moreover, because the development of this API followed an incremental approach with several overhauls along the way. The flexibility in the DBMS provided more leeway for structural changes when they were required, and it was this exact reason that drove the team to make this decision.
