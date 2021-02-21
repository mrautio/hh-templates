#!/bin/bash

set -euxo pipefail

TESTCASE=""

assert_ret ()
{
	RET="$1"
	EXPECTED="$2"

	if [ "$RET" -ne "$EXPECTED" ]
	then
		echo "Return code invalid! Expected '${EXPECTED}', actual:'${RET}', testcase:'${TESTCASE}'"
		exit 2
	fi
}

assert_file_exists ()
{
	if [ ! -f "$1" ]
	then
		echo "File not found: $1. testcase:'${TESTCASE}'"
		exit 3
	fi
}

assert_expected_and_actual_pdf ()
{
	FILEPDFEXPECTED="$1"
	FILEPDFACTUAL="$2"

	if [ -f $FILEPDFEXPECTED ]
	then
		# compare returns 0 when should return 1??? grep kludge to do the assert as retval having issues
		compare -verbose -metric AE $FILEPDFEXPECTED $FILEPDFACTUAL null: 2>/tmp/compareoutput || assert_ret $? 0
		cat /tmp/compareoutput
		grep "all: 0" /tmp/compareoutput || assert_ret $? 0
	else
		echo "Expected PDF $FILEPDFEXPECTED not found. Will not attempt document comparison."
	fi	
}

create_pdf ()
{
	FILEMD="$1"
	TEMPLATETYPE="$2"

	assert_file_exists $FILEMD

	FILEPDF="${FILEMD}_actual_${TEMPLATETYPE}.pdf"
	FILEPDFEXPECTED="${FILEMD}_expected_${TEMPLATETYPE}.pdf"

	# Ensure that PDF conversion completes successfully
	pandoc --from markdown --template hhtemplate.tex --filter pandoc-tablenos --filter pandoc-fignos --filter pandoc-citeproc --pdf-engine=xelatex --listings --variable=hhdocumentfont:FreeSans --csl=/tmp/haaga-helia-university-of-applied-sciences-harvard.csl --verbose -o $FILEPDF $FILEMD --variable=hhtemplatetype:$TEMPLATETYPE || assert_ret $? 0

	assert_file_exists $FILEPDF

	assert_expected_and_actual_pdf $FILEPDFEXPECTED $FILEPDF
}

assert_md_template_processing ()
{
	FILE="$1"
	TESTCASE=$FILE

	create_pdf $FILE short
	create_pdf $FILE long
	create_pdf $FILE thesis

	echo TEST CASE $TESTCASE SUCCESS
}

shopt -s globstar

# NOTE: repo's README.md is duplicated to case directory
#       to prevent GitHub status badge volatility

for FILE in cases/**/*.md
do
	assert_md_template_processing "$FILE"
done

