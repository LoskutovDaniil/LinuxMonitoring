#!/bin/bash

fon_first=""
text_first=""
fon_second=""
text_second=""

. ./output.sh
. ./colors.txt

if [[ $# == 0 ]] && [[ -f "colors.txt" ]]; then
    if check_colors_variable "column1_background" "$column1_background"; then
        parser1 $column1_background
        flag_exis_1=1;
    else
        text_first=40;
    fi

    if check_colors_variable "column1_font_color" "$column1_font_color"; then
        parser2 $column1_font_color
        flag_exis_2=1;
    else
        fon_first=97;
    fi

    if check_colors_variable "column2_background" "$column2_background"; then
        parser3 $column2_background
        flag_exis_3=1;
    else
        text_second=101;
    fi

    if check_colors_variable "column2_font_color" "$column2_font_color"; then
        parser4 $column2_font_color
        flag_exis_4=1;
    else
        fon_second=96;
    fi
    output
fi

if [[ $flag_exis_1 == 1 ]]; then          
        echo ""
        echo "Column 1 background = $column1_background ($(parser_color $column1_background))"
else                                          
        echo ""
        echo "Column 1 background = default (black)"
fi

if [[ $flag_exis_2 == 1 ]]; then
        echo "Column 1 font color = $column1_font_color ($(parser_color $column1_font_color))"
else
        echo "Column 1 font color = default (white)"
fi

if [[ $flag_exis_3 == 1 ]]; then
        echo "Column 2 background = $column2_background ($(parser_color $column2_background))"
else
        echo "Column 2 background = default (red)"
fi

if [[ $flag_exis_4 == 1 ]]; then
        echo "Column 2 font color = $column2_font_color ($(parser_color $column2_font_color))"
else
        echo "Column 2 font color = default (blue)"
fi