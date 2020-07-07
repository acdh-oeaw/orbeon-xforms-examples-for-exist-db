Orbeon XFroms Examples
======================

Prerequisites
-------------

* You need to add orbeon to your exist servlet container
* You need to change the context of exist from /exist to /
* You need to set up orbeon-xfroms-filter to be applied in /apps/orbeon-forms/xforms

Quick start
-----------

We use this kind of setup for [MerMEId](https://github.com/Edirom/MerMEId/tree/develop).
This repository is also available as a [docker container](https://hub.docker.com/r/edirom/mermeid).

`docker pull edirom/mermeid:develop`

For example (Windows, Docker Desktop):
Note that this will _delete everything_ when stopped except a directory that can be used for eXide synchronisation.)

`docker run -p 8080:8080 -v X:\orbeon-xforms-examples:/orbeon-xforms-examples --rm -it edirom/mermeid:develop`
