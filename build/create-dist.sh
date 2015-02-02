#!/bin/sh

cat header.template > JsonServiceClient.swift

egrep -h -v '^(import|//)' \
      ../src/ServiceStackClient/ServiceStackClient/JsonServiceClient.swift \
      ../src/ServiceStackClient/ServiceStackClient/Json.swift \
      ../src/ServiceStackClient/ServiceStackClient/StringExtensions.swift \
      ../src/ServiceStackClient/ServiceStackClient/DateExtensions.swift \
      ../src/ServiceStackClient/ServiceStackClient/Promise.swift \
      >> JsonServiceClient.swift

mv JsonServiceClient.swift ../dist

