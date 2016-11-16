#!/bin/bash

javaws http://jenkins2/computer/`hostname -s`/slave-agent.jnlp
javaws http://jenkins2/computer/`hostname -s`_ANDROID/slave-agent.jnlp
javaws http://jenkins2/computer/`hostname -s`_IOS/slave-agent.jnlp
