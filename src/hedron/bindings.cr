@[Link(ldflags: "-lui")]
lib UI
  UIDRAWDEFAULTMITERLIMIT       =                                                             10.0
  UIPI                          = 3.14159265358979323846264338327950288419716939937510582097494459
  AlignCenter                 =                                                                2
  AlignEnd                    =                                                                3
  AlignFill                   =                                                                0
  AlignStart                  =                                                                1
  AtBottom                    =                                                                3
  AtLeading                   =                                                                0
  AtTop                       =                                                                1
  AtTrailing                  =                                                                2
  AttributeTypeBackground     =                                                                6
  AttributeTypeColor          =                                                                5
  AttributeTypeFamily         =                                                                0
  AttributeTypeFeatures       =                                                                9
  AttributeTypeItalic         =                                                                3
  AttributeTypeSize           =                                                                1
  AttributeTypeStretch        =                                                                4
  AttributeTypeUnderline      =                                                                7
  AttributeTypeUnderlineColor =                                                                8
  AttributeTypeWeight         =                                                                2
  DrawBrushTypeImage          =                                                                3
  DrawBrushTypeLinearGradient =                                                                1
  DrawBrushTypeRadialGradient =                                                                2
  DrawBrushTypeSolid          =                                                                0
  DrawFillModeAlternate       =                                                                1
  DrawFillModeWinding         =                                                                0
  DrawLineCapFlat             =                                                                0
  DrawLineCapRound            =                                                                1
  DrawLineCapSquare           =                                                                2
  DrawLineJoinBevel           =                                                                2
  DrawLineJoinMiter           =                                                                0
  DrawLineJoinRound           =                                                                1
  DrawTextAlignCenter         =                                                                1
  DrawTextAlignLeft           =                                                                0
  DrawTextAlignRight          =                                                                2
  ExtKeyDelete                =                                                                3
  ExtKeyDown                  =                                                                9
  ExtKeyEnd                   =                                                                5
  ExtKeyEscape                =                                                                1
  ExtKeyF1                    =                                                               12
  ExtKeyF10                   =                                                               21
  ExtKeyF11                   =                                                               22
  ExtKeyF12                   =                                                               23
  ExtKeyF2                    =                                                               13
  ExtKeyF3                    =                                                               14
  ExtKeyF4                    =                                                               15
  ExtKeyF5                    =                                                               16
  ExtKeyF6                    =                                                               17
  ExtKeyF7                    =                                                               18
  ExtKeyF8                    =                                                               19
  ExtKeyF9                    =                                                               20
  ExtKeyHome                  =                                                                4
  ExtKeyInsert                =                                                                2
  ExtKeyLeft                  =                                                               10
  ExtKeyN0                    =                                                               24
  ExtKeyN1                    =                                                               25
  ExtKeyN2                    =                                                               26
  ExtKeyN3                    =                                                               27
  ExtKeyN4                    =                                                               28
  ExtKeyN5                    =                                                               29
  ExtKeyN6                    =                                                               30
  ExtKeyN7                    =                                                               31
  ExtKeyN8                    =                                                               32
  ExtKeyN9                    =                                                               33
  ExtKeyNAdd                  =                                                               36
  ExtKeyNDivide               =                                                               39
  ExtKeyNDot                  =                                                               34
  ExtKeyNEnter                =                                                               35
  ExtKeyNMultiply             =                                                               38
  ExtKeyNSubtract             =                                                               37
  ExtKeyPageDown              =                                                                7
  ExtKeyPageUp                =                                                                6
  ExtKeyRight                 =                                                               11
  ExtKeyUp                    =                                                                8
  ForEachContinue             =                                                                0
  ForEachStop                 =                                                                1
  ModifierAlt                 =                                                                2
  ModifierCtrl                =                                                                1
  ModifierShift               =                                                                4
  ModifierSuper               =                                                                8
  TextItalicItalic            =                                                                2
  TextItalicNormal            =                                                                0
  TextItalicOblique           =                                                                1
  TextStretchCondensed        =                                                                2
  TextStretchExpanded         =                                                                6
  TextStretchExtraCondensed   =                                                                1
  TextStretchExtraExpanded    =                                                                7
  TextStretchNormal           =                                                                4
  TextStretchSemiCondensed    =                                                                3
  TextStretchSemiExpanded     =                                                                5
  TextStretchUltraCondensed   =                                                                0
  TextStretchUltraExpanded    =                                                                8
  TextWeightBold              =                                                              700
  TextWeightBook              =                                                              350
  TextWeightHeavy             =                                                              900
  TextWeightLight             =                                                              300
  TextWeightMaximum           =                                                             1000
  TextWeightMedium            =                                                              500
  TextWeightMinimum           =                                                                0
  TextWeightNormal            =                                                              400
  TextWeightSemiBold          =                                                              600
  TextWeightThin              =                                                              100
  TextWeightUltraBold         =                                                              800
  TextWeightUltraHeavy        =                                                              950
  TextWeightUltraLight        =                                                              200
  UnderlineColorAuxiliary     =                                                                3
  UnderlineColorCustom        =                                                                0
  UnderlineColorGrammar       =                                                                2
  UnderlineColorSpelling      =                                                                1
  UnderlineDouble             =                                                                2
  UnderlineNone               =                                                                0
  UnderlineSingle             =                                                                1
  UnderlineSuggestion         =                                                                3
  WindowResizeEdgeBottom      =                                                                3
  WindowResizeEdgeBottomLeft  =                                                                6
  WindowResizeEdgeBottomRight =                                                                7
  WindowResizeEdgeLeft        =                                                                0
  WindowResizeEdgeRight       =                                                                2
  WindowResizeEdgeTop         =                                                                1
  WindowResizeEdgeTopLeft     =                                                                4
  WindowResizeEdgeTopRight    =                                                                5

  alias Align = LibC::UInt
  alias At = LibC::UInt
  alias AttributeType = LibC::UInt
  alias AttributedStringForEachAttributeFunc = (AttributedString*, Attribute*, LibC::SizeT, LibC::SizeT, Void* -> ForEach)
  alias DrawBrushType = LibC::UInt
  alias DrawFillMode = LibC::UInt
  alias DrawLineCap = LibC::UInt
  alias DrawLineJoin = LibC::UInt
  alias DrawTextAlign = LibC::UInt
  alias ExtKey = LibC::UInt
  alias ForEach = LibC::UInt
  alias Modifiers = LibC::UInt
  alias OpenTypeFeaturesForEachFunc = (OpenTypeFeatures*, LibC::Char, LibC::Char, LibC::Char, LibC::Char, Uint32T, Void* -> ForEach)
  alias TextItalic = LibC::UInt
  alias TextStretch = LibC::UInt
  alias TextWeight = LibC::UInt
  alias Underline = LibC::UInt
  alias UnderlineColor = LibC::UInt
  alias WindowResizeEdge = LibC::UInt
  alias Uint32T = LibC::UInt
  alias Uint64T = LibC::ULongLong
  alias UintptrT = LibC::ULong

  fun alloc_control = uiAllocControl(n : LibC::SizeT, o_ssig : Uint32T, typesig : Uint32T, typenamestr : LibC::Char*) : Control*

  fun area_begin_user_window_move = uiAreaBeginUserWindowMove(a : Area*)
  fun area_begin_user_window_resize = uiAreaBeginUserWindowResize(a : Area*, edge : WindowResizeEdge)
  fun area_queue_redraw_all = uiAreaQueueRedrawAll(a : Area*)
  fun area_scroll_to = uiAreaScrollTo(a : Area*, x : LibC::Double, y : LibC::Double, width : LibC::Double, height : LibC::Double)
  fun area_set_size = uiAreaSetSize(a : Area*, width : LibC::Int, height : LibC::Int)

  fun attribute_color = uiAttributeColor(a : Attribute*, r : LibC::Double*, g : LibC::Double*, b : LibC::Double*, alpha : LibC::Double*)
  fun attribute_family = uiAttributeFamily(a : Attribute*) : LibC::Char*
  fun attribute_features = uiAttributeFeatures(a : Attribute*) : OpenTypeFeatures*
  fun attribute_get_type = uiAttributeGetType(a : Attribute*) : AttributeType
  fun attribute_italic = uiAttributeItalic(a : Attribute*) : TextItalic
  fun attribute_size = uiAttributeSize(a : Attribute*) : LibC::Double
  fun attribute_stretch = uiAttributeStretch(a : Attribute*) : TextStretch
  fun attribute_underline = uiAttributeUnderline(a : Attribute*) : Underline
  fun attribute_underline_color = uiAttributeUnderlineColor(a : Attribute*, u : UnderlineColor*, r : LibC::Double*, g : LibC::Double*, b : LibC::Double*, alpha : LibC::Double*)
  fun attribute_weight = uiAttributeWeight(a : Attribute*) : TextWeight

  fun attributed_string_append_unattributed = uiAttributedStringAppendUnattributed(s : AttributedString*, str : LibC::Char*)
  fun attributed_string_byte_index_to_grapheme = uiAttributedStringByteIndexToGrapheme(s : AttributedString*, pos : LibC::SizeT) : LibC::SizeT
  fun attributed_string_delete = uiAttributedStringDelete(s : AttributedString*, start : LibC::SizeT, _end : LibC::SizeT)
  fun attributed_string_for_each_attribute = uiAttributedStringForEachAttribute(s : AttributedString*, f : AttributedStringForEachAttributeFunc, data : Void*)
  fun attributed_string_grapheme_to_byte_index = uiAttributedStringGraphemeToByteIndex(s : AttributedString*, pos : LibC::SizeT) : LibC::SizeT
  fun attributed_string_insert_at_unattributed = uiAttributedStringInsertAtUnattributed(s : AttributedString*, str : LibC::Char*, at : LibC::SizeT)
  fun attributed_string_len = uiAttributedStringLen(s : AttributedString*) : LibC::SizeT
  fun attributed_string_num_graphemes = uiAttributedStringNumGraphemes(s : AttributedString*) : LibC::SizeT
  fun attributed_string_set_attribute = uiAttributedStringSetAttribute(s : AttributedString*, a : Attribute*, start : LibC::SizeT, _end : LibC::SizeT)
  fun attributed_string_string = uiAttributedStringString(s : AttributedString*) : LibC::Char*

  fun box_append = uiBoxAppend(b : Box*, child : Control*, stretchy : LibC::Int)
  fun box_delete = uiBoxDelete(b : Box*, index : LibC::Int)
  fun box_padded = uiBoxPadded(b : Box*) : LibC::Int
  fun box_set_padded = uiBoxSetPadded(b : Box*, padded : LibC::Int)

  fun button_on_clicked = uiButtonOnClicked(b : Button*, f : (Button*, Void* -> Void), data : Void*)
  fun button_set_text = uiButtonSetText(b : Button*, text : LibC::Char*)
  fun button_text = uiButtonText(b : Button*) : LibC::Char*

  fun checkbox_checked = uiCheckboxChecked(c : Checkbox*) : LibC::Int
  fun checkbox_on_toggled = uiCheckboxOnToggled(c : Checkbox*, f : (Checkbox*, Void* -> Void), data : Void*)
  fun checkbox_set_checked = uiCheckboxSetChecked(c : Checkbox*, checked : LibC::Int)
  fun checkbox_set_text = uiCheckboxSetText(c : Checkbox*, text : LibC::Char*)
  fun checkbox_text = uiCheckboxText(c : Checkbox*) : LibC::Char*

  fun color_button_color = uiColorButtonColor(b : ColorButton*, r : LibC::Double*, g : LibC::Double*, bl : LibC::Double*, a : LibC::Double*)
  fun color_button_on_changed = uiColorButtonOnChanged(b : ColorButton*, f : (ColorButton*, Void* -> Void), data : Void*)
  fun color_button_set_color = uiColorButtonSetColor(b : ColorButton*, r : LibC::Double, g : LibC::Double, bl : LibC::Double, a : LibC::Double)

  fun combobox_append = uiComboboxAppend(c : Combobox*, text : LibC::Char*)
  fun combobox_on_selected = uiComboboxOnSelected(c : Combobox*, f : (Combobox*, Void* -> Void), data : Void*)
  fun combobox_selected = uiComboboxSelected(c : Combobox*) : LibC::Int
  fun combobox_set_selected = uiComboboxSetSelected(c : Combobox*, n : LibC::Int)

  fun control_destroy = uiControlDestroy(x0 : Control*)
  fun control_disable = uiControlDisable(x0 : Control*)
  fun control_enable = uiControlEnable(x0 : Control*)
  fun control_enabled = uiControlEnabled(x0 : Control*) : LibC::Int
  fun control_enabled_to_user = uiControlEnabledToUser(x0 : Control*) : LibC::Int
  fun control_handle = uiControlHandle(x0 : Control*) : UintptrT
  fun control_hide = uiControlHide(x0 : Control*)
  fun control_parent = uiControlParent(x0 : Control*) : Control*
  fun control_set_parent = uiControlSetParent(x0 : Control*, x1 : Control*)
  fun control_show = uiControlShow(x0 : Control*)
  fun control_toplevel = uiControlToplevel(x0 : Control*) : LibC::Int
  fun control_verify_set_parent = uiControlVerifySetParent(x0 : Control*, x1 : Control*)
  fun control_visible = uiControlVisible(x0 : Control*) : LibC::Int

  fun draw_clip = uiDrawClip(c : DrawContext*, path : DrawPath*)
  fun draw_fill = uiDrawFill(c : DrawContext*, path : DrawPath*, b : DrawBrush*)
  fun draw_free_path = uiDrawFreePath(p : DrawPath*)
  fun draw_free_text_layout = uiDrawFreeTextLayout(tl : DrawTextLayout*)
  fun draw_matrix_invert = uiDrawMatrixInvert(m : DrawMatrix*) : LibC::Int
  fun draw_matrix_invertible = uiDrawMatrixInvertible(m : DrawMatrix*) : LibC::Int
  fun draw_matrix_multiply = uiDrawMatrixMultiply(dest : DrawMatrix*, src : DrawMatrix*)
  fun draw_matrix_rotate = uiDrawMatrixRotate(m : DrawMatrix*, x : LibC::Double, y : LibC::Double, amount : LibC::Double)
  fun draw_matrix_scale = uiDrawMatrixScale(m : DrawMatrix*, x_center : LibC::Double, y_center : LibC::Double, x : LibC::Double, y : LibC::Double)
  fun draw_matrix_set_identity = uiDrawMatrixSetIdentity(m : DrawMatrix*)
  fun draw_matrix_skew = uiDrawMatrixSkew(m : DrawMatrix*, x : LibC::Double, y : LibC::Double, xamount : LibC::Double, yamount : LibC::Double)
  fun draw_matrix_transform_point = uiDrawMatrixTransformPoint(m : DrawMatrix*, x : LibC::Double*, y : LibC::Double*)
  fun draw_matrix_transform_size = uiDrawMatrixTransformSize(m : DrawMatrix*, x : LibC::Double*, y : LibC::Double*)
  fun draw_matrix_translate = uiDrawMatrixTranslate(m : DrawMatrix*, x : LibC::Double, y : LibC::Double)

  fun draw_new_path = uiDrawNewPath(fill_mode : DrawFillMode) : DrawPath*
  fun draw_new_text_layout = uiDrawNewTextLayout(params : DrawTextLayoutParams*) : DrawTextLayout*

  fun draw_path_add_rectangle = uiDrawPathAddRectangle(p : DrawPath*, x : LibC::Double, y : LibC::Double, width : LibC::Double, height : LibC::Double)
  fun draw_path_arc_to = uiDrawPathArcTo(p : DrawPath*, x_center : LibC::Double, y_center : LibC::Double, radius : LibC::Double, start_angle : LibC::Double, sweep : LibC::Double, negative : LibC::Int)
  fun draw_path_bezier_to = uiDrawPathBezierTo(p : DrawPath*, c1x : LibC::Double, c1y : LibC::Double, c2x : LibC::Double, c2y : LibC::Double, end_x : LibC::Double, end_y : LibC::Double)
  fun draw_path_close_figure = uiDrawPathCloseFigure(p : DrawPath*)
  fun draw_path_end = uiDrawPathEnd(p : DrawPath*)
  fun draw_path_line_to = uiDrawPathLineTo(p : DrawPath*, x : LibC::Double, y : LibC::Double)
  fun draw_path_new_figure = uiDrawPathNewFigure(p : DrawPath*, x : LibC::Double, y : LibC::Double)
  fun draw_path_new_figure_with_arc = uiDrawPathNewFigureWithArc(p : DrawPath*, x_center : LibC::Double, y_center : LibC::Double, radius : LibC::Double, start_angle : LibC::Double, sweep : LibC::Double, negative : LibC::Int)

  fun draw_restore = uiDrawRestore(c : DrawContext*)
  fun draw_save = uiDrawSave(c : DrawContext*)
  fun draw_stroke = uiDrawStroke(c : DrawContext*, path : DrawPath*, b : DrawBrush*, p : DrawStrokeParams*)
  fun draw_text = uiDrawText(c : DrawContext*, tl : DrawTextLayout*, x : LibC::Double, y : LibC::Double)
  fun draw_text_layout_extents = uiDrawTextLayoutExtents(tl : DrawTextLayout*, width : LibC::Double*, height : LibC::Double*)
  fun draw_transform = uiDrawTransform(c : DrawContext*, m : DrawMatrix*)

  fun editable_combobox_append = uiEditableComboboxAppend(c : EditableCombobox*, text : LibC::Char*)
  fun editable_combobox_on_changed = uiEditableComboboxOnChanged(c : EditableCombobox*, f : (EditableCombobox*, Void* -> Void), data : Void*)
  fun editable_combobox_set_text = uiEditableComboboxSetText(c : EditableCombobox*, text : LibC::Char*)
  fun editable_combobox_text = uiEditableComboboxText(c : EditableCombobox*) : LibC::Char*

  fun entry_on_changed = uiEntryOnChanged(e : Entry*, f : (Entry*, Void* -> Void), data : Void*)
  fun entry_read_only = uiEntryReadOnly(e : Entry*) : LibC::Int
  fun entry_set_read_only = uiEntrySetReadOnly(e : Entry*, readonly : LibC::Int)
  fun entry_set_text = uiEntrySetText(e : Entry*, text : LibC::Char*)
  fun entry_text = uiEntryText(e : Entry*) : LibC::Char*

  fun font_button_font = uiFontButtonFont(b : FontButton*, desc : FontDescriptor*)
  fun font_button_on_changed = uiFontButtonOnChanged(b : FontButton*, f : (FontButton*, Void* -> Void), data : Void*)

  fun form_append = uiFormAppend(f : Form*, label : LibC::Char*, c : Control*, stretchy : LibC::Int)
  fun form_delete = uiFormDelete(f : Form*, index : LibC::Int)
  fun form_padded = uiFormPadded(f : Form*) : LibC::Int
  fun form_set_padded = uiFormSetPadded(f : Form*, padded : LibC::Int)

  fun free_attribute = uiFreeAttribute(a : Attribute*)
  fun free_attributed_string = uiFreeAttributedString(s : AttributedString*)
  fun free_control = uiFreeControl(x0 : Control*)
  fun free_font_button_font = uiFreeFontButtonFont(desc : FontDescriptor*)
  fun free_init_error = uiFreeInitError(err : LibC::Char*)
  fun free_open_type_features = uiFreeOpenTypeFeatures(otf : OpenTypeFeatures*)
  fun free_text = uiFreeText(text : LibC::Char*)

  fun grid_append = uiGridAppend(g : Grid*, c : Control*, left : LibC::Int, top : LibC::Int, xspan : LibC::Int, yspan : LibC::Int, hexpand : LibC::Int, halign : Align, vexpand : LibC::Int, valign : Align)
  fun grid_insert_at = uiGridInsertAt(g : Grid*, c : Control*, existing : Control*, at : At, xspan : LibC::Int, yspan : LibC::Int, hexpand : LibC::Int, halign : Align, vexpand : LibC::Int, valign : Align)
  fun grid_padded = uiGridPadded(g : Grid*) : LibC::Int
  fun grid_set_padded = uiGridSetPadded(g : Grid*, padded : LibC::Int)

  fun group_margined = uiGroupMargined(g : Group*) : LibC::Int
  fun group_set_child = uiGroupSetChild(g : Group*, c : Control*)
  fun group_set_margined = uiGroupSetMargined(g : Group*, margined : LibC::Int)
  fun group_set_title = uiGroupSetTitle(g : Group*, title : LibC::Char*)
  fun group_title = uiGroupTitle(g : Group*) : LibC::Char*

  fun init = uiInit(options : InitOptions*) : LibC::Char*

  fun label_set_text = uiLabelSetText(l : Label*, text : LibC::Char*)
  fun label_text = uiLabelText(l : Label*) : LibC::Char*

  fun main = uiMain
  fun main_step = uiMainStep(wait : LibC::Int) : LibC::Int
  fun main_steps = uiMainSteps

  fun menu_append_about_item = uiMenuAppendAboutItem(m : Menu*) : MenuItem*
  fun menu_append_check_item = uiMenuAppendCheckItem(m : Menu*, name : LibC::Char*) : MenuItem*
  fun menu_append_item = uiMenuAppendItem(m : Menu*, name : LibC::Char*) : MenuItem*
  fun menu_append_preferences_item = uiMenuAppendPreferencesItem(m : Menu*) : MenuItem*
  fun menu_append_quit_item = uiMenuAppendQuitItem(m : Menu*) : MenuItem*
  fun menu_append_separator = uiMenuAppendSeparator(m : Menu*)

  fun menu_item_checked = uiMenuItemChecked(m : MenuItem*) : LibC::Int
  fun menu_item_disable = uiMenuItemDisable(m : MenuItem*)
  fun menu_item_enable = uiMenuItemEnable(m : MenuItem*)
  fun menu_item_on_clicked = uiMenuItemOnClicked(m : MenuItem*, f : (MenuItem*, Window*, Void* -> Void), data : Void*)
  fun menu_item_set_checked = uiMenuItemSetChecked(m : MenuItem*, checked : LibC::Int)

  fun msg_box = uiMsgBox(parent : Window*, title : LibC::Char*, description : LibC::Char*)
  fun msg_box_error = uiMsgBoxError(parent : Window*, title : LibC::Char*, description : LibC::Char*)

  fun multiline_entry_append = uiMultilineEntryAppend(e : MultilineEntry*, text : LibC::Char*)
  fun multiline_entry_on_changed = uiMultilineEntryOnChanged(e : MultilineEntry*, f : (MultilineEntry*, Void* -> Void), data : Void*)
  fun multiline_entry_read_only = uiMultilineEntryReadOnly(e : MultilineEntry*) : LibC::Int
  fun multiline_entry_set_read_only = uiMultilineEntrySetReadOnly(e : MultilineEntry*, readonly : LibC::Int)
  fun multiline_entry_set_text = uiMultilineEntrySetText(e : MultilineEntry*, text : LibC::Char*)
  fun multiline_entry_text = uiMultilineEntryText(e : MultilineEntry*) : LibC::Char*

  fun new_area = uiNewArea(ah : AreaHandler*) : Area*
  fun new_attributed_string = uiNewAttributedString(initial_string : LibC::Char*) : AttributedString*
  fun new_background_attribute = uiNewBackgroundAttribute(r : LibC::Double, g : LibC::Double, b : LibC::Double, a : LibC::Double) : Attribute*
  fun new_button = uiNewButton(text : LibC::Char*) : Button*
  fun new_checkbox = uiNewCheckbox(text : LibC::Char*) : Checkbox*
  fun new_color_attribute = uiNewColorAttribute(r : LibC::Double, g : LibC::Double, b : LibC::Double, a : LibC::Double) : Attribute*
  fun new_color_button = uiNewColorButton : ColorButton*
  fun new_combobox = uiNewCombobox : Combobox*
  fun new_date_picker = uiNewDatePicker : DateTimePicker*
  fun new_date_time_picker = uiNewDateTimePicker : DateTimePicker*
  fun new_editable_combobox = uiNewEditableCombobox : EditableCombobox*
  fun new_entry = uiNewEntry : Entry*
  fun new_family_attribute = uiNewFamilyAttribute(family : LibC::Char*) : Attribute*
  fun new_features_attribute = uiNewFeaturesAttribute(otf : OpenTypeFeatures*) : Attribute*
  fun new_font_button = uiNewFontButton : FontButton*
  fun new_form = uiNewForm : Form*
  fun new_grid = uiNewGrid : Grid*
  fun new_group = uiNewGroup(title : LibC::Char*) : Group*
  fun new_horizontal_box = uiNewHorizontalBox : Box*
  fun new_horizontal_separator = uiNewHorizontalSeparator : Separator*
  fun new_italic_attribute = uiNewItalicAttribute(italic : TextItalic) : Attribute*
  fun new_label = uiNewLabel(text : LibC::Char*) : Label*
  fun new_menu = uiNewMenu(name : LibC::Char*) : Menu*
  fun new_multiline_entry = uiNewMultilineEntry : MultilineEntry*
  fun new_non_wrapping_multiline_entry = uiNewNonWrappingMultilineEntry : MultilineEntry*
  fun new_open_type_features = uiNewOpenTypeFeatures : OpenTypeFeatures*
  fun new_password_entry = uiNewPasswordEntry : Entry*
  fun new_progress_bar = uiNewProgressBar : ProgressBar*
  fun new_radio_buttons = uiNewRadioButtons : RadioButtons*
  fun new_scrolling_area = uiNewScrollingArea(ah : AreaHandler*, width : LibC::Int, height : LibC::Int) : Area*
  fun new_search_entry = uiNewSearchEntry : Entry*
  fun new_size_attribute = uiNewSizeAttribute(size : LibC::Double) : Attribute*
  fun new_slider = uiNewSlider(min : LibC::Int, max : LibC::Int) : Slider*
  fun new_spinbox = uiNewSpinbox(min : LibC::Int, max : LibC::Int) : Spinbox*
  fun new_stretch_attribute = uiNewStretchAttribute(stretch : TextStretch) : Attribute*
  fun new_tab = uiNewTab : Tab*
  fun new_time_picker = uiNewTimePicker : DateTimePicker*
  fun new_underline_attribute = uiNewUnderlineAttribute(u : Underline) : Attribute*
  fun new_underline_color_attribute = uiNewUnderlineColorAttribute(u : UnderlineColor, r : LibC::Double, g : LibC::Double, b : LibC::Double, a : LibC::Double) : Attribute*
  fun new_vertical_box = uiNewVerticalBox : Box*
  fun new_vertical_separator = uiNewVerticalSeparator : Separator*
  fun new_weight_attribute = uiNewWeightAttribute(weight : TextWeight) : Attribute*
  fun new_window = uiNewWindow(title : LibC::Char*, width : LibC::Int, height : LibC::Int, has_menubar : LibC::Int) : Window*

  fun on_should_quit = uiOnShouldQuit(f : (Void* -> LibC::Int), data : Void*)

  fun open_file = uiOpenFile(parent : Window*) : LibC::Char*

  fun open_type_features_add = uiOpenTypeFeaturesAdd(otf : OpenTypeFeatures*, a : LibC::Char, b : LibC::Char, c : LibC::Char, d : LibC::Char, value : Uint32T)
  fun open_type_features_clone = uiOpenTypeFeaturesClone(otf : OpenTypeFeatures*) : OpenTypeFeatures*
  fun open_type_features_for_each = uiOpenTypeFeaturesForEach(otf : OpenTypeFeatures*, f : OpenTypeFeaturesForEachFunc, data : Void*)
  fun open_type_features_get = uiOpenTypeFeaturesGet(otf : OpenTypeFeatures*, a : LibC::Char, b : LibC::Char, c : LibC::Char, d : LibC::Char, value : Uint32T*) : LibC::Int
  fun open_type_features_remove = uiOpenTypeFeaturesRemove(otf : OpenTypeFeatures*, a : LibC::Char, b : LibC::Char, c : LibC::Char, d : LibC::Char)

  fun progress_bar_set_value = uiProgressBarSetValue(p : ProgressBar*, n : LibC::Int)
  fun progress_bar_value = uiProgressBarValue(p : ProgressBar*) : LibC::Int

  fun queue_main = uiQueueMain(f : (Void* -> Void), data : Void*)

  fun quit = uiQuit

  fun radio_buttons_append = uiRadioButtonsAppend(r : RadioButtons*, text : LibC::Char*)
  fun radio_buttons_on_selected = uiRadioButtonsOnSelected(r : RadioButtons*, f : (RadioButtons*, Void* -> Void), data : Void*)
  fun radio_buttons_selected = uiRadioButtonsSelected(r : RadioButtons*) : LibC::Int
  fun radio_buttons_set_selected = uiRadioButtonsSetSelected(r : RadioButtons*, n : LibC::Int)

  fun save_file = uiSaveFile(parent : Window*) : LibC::Char*

  fun slider_on_changed = uiSliderOnChanged(s : Slider*, f : (Slider*, Void* -> Void), data : Void*)
  fun slider_set_value = uiSliderSetValue(s : Slider*, value : LibC::Int)
  fun slider_value = uiSliderValue(s : Slider*) : LibC::Int

  fun spinbox_on_changed = uiSpinboxOnChanged(s : Spinbox*, f : (Spinbox*, Void* -> Void), data : Void*)
  fun spinbox_set_value = uiSpinboxSetValue(s : Spinbox*, value : LibC::Int)
  fun spinbox_value = uiSpinboxValue(s : Spinbox*) : LibC::Int

  fun tab_append = uiTabAppend(t : Tab*, name : LibC::Char*, c : Control*)
  fun tab_delete = uiTabDelete(t : Tab*, index : LibC::Int)
  fun tab_insert_at = uiTabInsertAt(t : Tab*, name : LibC::Char*, before : LibC::Int, c : Control*)
  fun tab_margined = uiTabMargined(t : Tab*, page : LibC::Int) : LibC::Int
  fun tab_num_pages = uiTabNumPages(t : Tab*) : LibC::Int
  fun tab_set_margined = uiTabSetMargined(t : Tab*, page : LibC::Int, margined : LibC::Int)

  fun uninit = uiUninit

  fun user_bug_cannot_set_parent_on_toplevel = uiUserBugCannotSetParentOnToplevel(type : LibC::Char*)

  fun window_borderless = uiWindowBorderless(w : Window*) : LibC::Int
  fun window_content_size = uiWindowContentSize(w : Window*, width : LibC::Int*, height : LibC::Int*)
  fun window_fullscreen = uiWindowFullscreen(w : Window*) : LibC::Int
  fun window_margined = uiWindowMargined(w : Window*) : LibC::Int
  fun window_on_closing = uiWindowOnClosing(w : Window*, f : (Window*, Void* -> LibC::Int), data : Void*)
  fun window_on_content_size_changed = uiWindowOnContentSizeChanged(w : Window*, f : (Window*, Void* -> Void), data : Void*)
  fun window_set_borderless = uiWindowSetBorderless(w : Window*, borderless : LibC::Int)
  fun window_set_child = uiWindowSetChild(w : Window*, child : Control*)
  fun window_set_content_size = uiWindowSetContentSize(w : Window*, width : LibC::Int, height : LibC::Int)
  fun window_set_fullscreen = uiWindowSetFullscreen(w : Window*, fullscreen : LibC::Int)
  fun window_set_margined = uiWindowSetMargined(w : Window*, margined : LibC::Int)
  fun window_set_title = uiWindowSetTitle(w : Window*, title : LibC::Char*)
  fun window_title = uiWindowTitle(w : Window*) : LibC::Char*

  struct AreaDrawParams
    context : DrawContext*
    area_width : LibC::Double
    area_height : LibC::Double
    clip_x : LibC::Double
    clip_y : LibC::Double
    clip_width : LibC::Double
    clip_height : LibC::Double
  end

  struct AreaHandler
    draw : (AreaHandler*, Area*, AreaDrawParams* -> Void)
    mouse_event : (AreaHandler*, Area*, AreaMouseEvent* -> Void)
    mouse_crossed : (AreaHandler*, Area*, LibC::Int -> Void)
    drag_broken : (AreaHandler*, Area* -> Void)
    key_event : (AreaHandler*, Area*, AreaKeyEvent* -> LibC::Int)
  end

  struct AreaKeyEvent
    key : LibC::Char
    ext_key : ExtKey
    modifier : Modifiers
    modifiers : Modifiers
    up : LibC::Int
  end

  struct AreaMouseEvent
    x : LibC::Double
    y : LibC::Double
    area_width : LibC::Double
    area_height : LibC::Double
    down : LibC::Int
    up : LibC::Int
    count : LibC::Int
    modifiers : Modifiers
    held1_to64 : Uint64T
  end

  struct Control
    signature : Uint32T
    os_signature : Uint32T
    type_signature : Uint32T
    destroy : (Control* -> Void)
    handle : (Control* -> UintptrT)
    parent : (Control* -> Control*)
    set_parent : (Control*, Control* -> Void)
    toplevel : (Control* -> LibC::Int)
    visible : (Control* -> LibC::Int)
    show : (Control* -> Void)
    hide : (Control* -> Void)
    enabled : (Control* -> LibC::Int)
    enable : (Control* -> Void)
    disable : (Control* -> Void)
  end

  struct DrawBrush
    type : DrawBrushType
    r : LibC::Double
    g : LibC::Double
    b : LibC::Double
    a : LibC::Double
    x0 : LibC::Double
    y0 : LibC::Double
    x1 : LibC::Double
    y1 : LibC::Double
    outer_radius : LibC::Double
    stops : DrawBrushGradientStop*
    num_stops : LibC::SizeT
  end

  struct DrawBrushGradientStop
    pos : LibC::Double
    r : LibC::Double
    g : LibC::Double
    b : LibC::Double
    a : LibC::Double
  end

  struct DrawMatrix
    m11 : LibC::Double
    m12 : LibC::Double
    m21 : LibC::Double
    m22 : LibC::Double
    m31 : LibC::Double
    m32 : LibC::Double
  end

  struct DrawStrokeParams
    cap : DrawLineCap
    join : DrawLineJoin
    thickness : LibC::Double
    miter_limit : LibC::Double
    dashes : LibC::Double*
    num_dashes : LibC::SizeT
    dash_phase : LibC::Double
  end

  struct DrawTextLayoutParams
    string : AttributedString*
    default_font : FontDescriptor*
    width : LibC::Double
    align : DrawTextAlign
  end

  struct FontDescriptor
    family : LibC::Char*
    size : LibC::Double
    weight : TextWeight
    italic : TextItalic
    stretch : TextStretch
  end

  struct InitOptions
    size : LibC::SizeT
  end

  type Area = Void*
  type Attribute = Void*
  type AttributedString = Void*
  type Box = Void*
  type Button = Void*
  type Checkbox = Void*
  type ColorButton = Void*
  type Combobox = Void*
  type DateTimePicker = Void*
  type DrawContext = Void*
  type DrawPath = Void*
  type DrawTextLayout = Void*
  type EditableCombobox = Void*
  type Entry = Void*
  type FontButton = Void*
  type Form = Void*
  type Grid = Void*
  type Group = Void*
  type Label = Void*
  type Menu = Void*
  type MenuItem = Void*
  type MultilineEntry = Void*
  type OpenTypeFeatures = Void*
  type ProgressBar = Void*
  type RadioButtons = Void*
  type Separator = Void*
  type Slider = Void*
  type Spinbox = Void*
  type Tab = Void*
  type Window = Void*
end

macro ui_control(control)
  {{control}}.unsafe_as(Pointer(UI::Control))
end

macro ui_box(control)
  {{control}}.unsafe_as(Pointer(UI::Box))
end

macro ui_nil?(ptr)
  {{ptr}}.null?
end
