import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_radio_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/admob_util.dart' as admob;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'quiz_one_question_model.dart';
export 'quiz_one_question_model.dart';

class QuizOneQuestionWidget extends StatefulWidget {
  const QuizOneQuestionWidget({super.key});

  static String routeName = 'quizOneQuestion';
  static String routePath = '/quizOneQuestion';

  @override
  State<QuizOneQuestionWidget> createState() => _QuizOneQuestionWidgetState();
}

class _QuizOneQuestionWidgetState extends State<QuizOneQuestionWidget>
    with TickerProviderStateMixin {
  late QuizOneQuestionModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => QuizOneQuestionModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (FFAppState().passQualification == 'INF.02') {
        _model.minValue = 1;
        _model.maxValue = 2120;
        safeSetState(() {});
      } else if (FFAppState().passQualification == 'INF.03') {
        _model.minValue = 2121;
        _model.maxValue = 3200;
        safeSetState(() {});
      } else if (FFAppState().passQualification == 'INF.04') {
        _model.minValue = 5058;
        _model.maxValue = 5685;
        safeSetState(() {});
      } else if (FFAppState().passQualification == 'ELE.02') {
        _model.minValue = 3201;
        _model.maxValue = 4759;
        safeSetState(() {});
      } else if (FFAppState().passQualification == 'ELE.05') {
        _model.minValue = 4760;
        _model.maxValue = 5057;
        safeSetState(() {});
      } else {
        return;
      }

      _model.randomNUM =
          functions.getRandomNumber(_model.minValue!, _model.maxValue!);
      _model.randomNumPass = _model.randomNUM;
      safeSetState(() {});
      await queryQuizQuestionsRecordOnce(
        queryBuilder: (quizQuestionsRecord) => quizQuestionsRecord.where(
          'question_id',
          isEqualTo: _model.randomNumPass,
        ),
        singleRecord: true,
      ).then((s) => s.firstOrNull);
      if (FFAppState().adCounter >= 4) {
        admob.loadInterstitialAd(
          "ca-app-pub-6394141425643906/5601492649",
          "ca-app-pub-6394141425643906/3081709894",
          false,
        );
      }
    });

    animationsMap.addAll({
      'columnOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 1.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return StreamBuilder<List<QuizQuestionsRecord>>(
      stream: queryQuizQuestionsRecord(
        queryBuilder: (quizQuestionsRecord) => quizQuestionsRecord.where(
          'question_id',
          isEqualTo: _model.randomNumPass,
        ),
        singleRecord: true,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: SpinKitFoldingCube(
                  color: FlutterFlowTheme.of(context).primary,
                  size: 50.0,
                ),
              ),
            ),
          );
        }
        List<QuizQuestionsRecord> quizOneQuestionQuizQuestionsRecordList =
            snapshot.data!;
        // Return an empty Container when the item does not exist.
        if (snapshot.data!.isEmpty) {
          return Container();
        }
        final quizOneQuestionQuizQuestionsRecord =
            quizOneQuestionQuizQuestionsRecordList.isNotEmpty
                ? quizOneQuestionQuizQuestionsRecordList.first
                : null;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              key: scaffoldKey,
              backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
              appBar: AppBar(
                backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
                automaticallyImplyLeading: false,
                title: Text(
                  'Jedno pytanie ${FFAppState().passQualification}',
                  style: FlutterFlowTheme.of(context).headlineSmall.override(
                        font: GoogleFonts.outfit(
                          fontWeight: FlutterFlowTheme.of(context)
                              .headlineSmall
                              .fontWeight,
                          fontStyle: FlutterFlowTheme.of(context)
                              .headlineSmall
                              .fontStyle,
                        ),
                        letterSpacing: 0.0,
                        fontWeight: FlutterFlowTheme.of(context)
                            .headlineSmall
                            .fontWeight,
                        fontStyle: FlutterFlowTheme.of(context)
                            .headlineSmall
                            .fontStyle,
                      ),
                ),
                actions: [],
                centerTitle: false,
                elevation: 0.0,
              ),
              body: SafeArea(
                top: true,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 8.0, 16.0, 0.0),
                              child: Text(
                                'Zaznacz prawidłową odpowiedź',
                                style: FlutterFlowTheme.of(context)
                                    .bodyLarge
                                    .override(
                                      font: GoogleFonts.manrope(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyLarge
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyLarge
                                            .fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .fontStyle,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 10.0, 16.0, 0.0),
                              child: Text(
                                valueOrDefault<String>(
                                  quizOneQuestionQuizQuestionsRecord
                                      ?.description,
                                  '1',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      font: GoogleFonts.manrope(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontStyle,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  12.0, 12.0, 12.0, 12.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  await Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.fade,
                                      child: FlutterFlowExpandedImageView(
                                        image: Image.network(
                                          quizOneQuestionQuizQuestionsRecord
                                              .questionPhoto,
                                          fit: BoxFit.contain,
                                        ),
                                        allowRotation: false,
                                        tag: quizOneQuestionQuizQuestionsRecord
                                            .questionPhoto,
                                        useHeroAnimation: true,
                                      ),
                                    ),
                                  );
                                },
                                child: Hero(
                                  tag: quizOneQuestionQuizQuestionsRecord!
                                      .questionPhoto,
                                  transitionOnUserGestures: true,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      quizOneQuestionQuizQuestionsRecord
                                          .questionPhoto,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 10.0, 16.0, 0.0),
                              child: Text(
                                'A. ${quizOneQuestionQuizQuestionsRecord.options.elementAtOrNull(0)}',
                                style: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      font: GoogleFonts.manrope(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontStyle,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 10.0, 16.0, 0.0),
                              child: Text(
                                'B. ${quizOneQuestionQuizQuestionsRecord.options.elementAtOrNull(1)}',
                                style: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      font: GoogleFonts.manrope(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontStyle,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 10.0, 16.0, 0.0),
                              child: Text(
                                'C. ${quizOneQuestionQuizQuestionsRecord.options.elementAtOrNull(2)}',
                                style: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      font: GoogleFonts.manrope(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontStyle,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 10.0, 16.0, 0.0),
                              child: Text(
                                'D. ${quizOneQuestionQuizQuestionsRecord.options.elementAtOrNull(3)}',
                                style: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      font: GoogleFonts.manrope(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontStyle,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 12.0, 12.0, 0.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Wrap(
                                  spacing: 0.0,
                                  runSpacing: 0.0,
                                  alignment: WrapAlignment.start,
                                  crossAxisAlignment: WrapCrossAlignment.start,
                                  direction: Axis.horizontal,
                                  runAlignment: WrapAlignment.start,
                                  verticalDirection: VerticalDirection.down,
                                  clipBehavior: Clip.none,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 0.0, 12.0, 0.0),
                                      child: FlutterFlowRadioButton(
                                        options: ['A', 'B', 'C', 'D'].toList(),
                                        onChanged: (val) async {
                                          safeSetState(() {});
                                          _model.selectedOption =
                                              _model.radioButtonValue;
                                          safeSetState(() {});
                                        },
                                        controller: _model
                                                .radioButtonValueController ??=
                                            FormFieldController<String>(null),
                                        optionHeight: 32.0,
                                        optionWidth:
                                            MediaQuery.sizeOf(context).width *
                                                0.15,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              font: GoogleFonts.manrope(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontStyle,
                                              ),
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontStyle,
                                            ),
                                        selectedTextStyle: FlutterFlowTheme.of(
                                                context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.manrope(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                        buttonPosition:
                                            RadioButtonPosition.left,
                                        direction: Axis.horizontal,
                                        radioButtonColor:
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                        inactiveRadioButtonColor:
                                            FlutterFlowTheme.of(context)
                                                .secondaryText,
                                        toggleable: false,
                                        horizontalAlignment:
                                            WrapAlignment.start,
                                        verticalAlignment:
                                            WrapCrossAlignment.start,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 32.0, 0.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 25.0),
                                      child: FFButtonWidget(
                                        onPressed: () async {
                                          _model.usersRefOneQuestion =
                                              await queryUsersRecordOnce(
                                            queryBuilder: (usersRecord) =>
                                                usersRecord.where(
                                              'email',
                                              isEqualTo: currentUserEmail,
                                            ),
                                            singleRecord: true,
                                          ).then((s) => s.firstOrNull);
                                          if (valueOrDefault<bool>(
                                                  currentUserDocument
                                                      ?.isUserPremium,
                                                  false) ==
                                              false) {
                                            if (FFAppState().adCounter >= 5) {
                                              _model.interstitialAdSuccess =
                                                  await admob
                                                      .showInterstitialAd();

                                              FFAppState().adCounter = 0;
                                              safeSetState(() {});
                                            }
                                          }
                                          if (_model.selectedOption ==
                                              quizOneQuestionQuizQuestionsRecord
                                                  .correctAnswerLetter) {
                                            // passNumANDAnswearToNextScreen
                                            FFAppState().previousQuestion =
                                                _model.randomNumPass!;
                                            FFAppState().previousAnswer =
                                                _model.selectedOption!;
                                            safeSetState(() {});

                                            await _model
                                                .usersRefOneQuestion!.reference
                                                .update({
                                              ...mapToFirestore(
                                                {
                                                  'correctAnswers':
                                                      FieldValue.increment(1),
                                                },
                                              ),
                                            });
                                            // Navigation to correct

                                            context.pushNamed(
                                                CorrectAnswerQuizWidget
                                                    .routeName);
                                          } else {
                                            // passNumANDAnswearToNextScreen
                                            FFAppState().previousQuestion =
                                                _model.randomNumPass!;
                                            FFAppState().previousAnswer =
                                                _model.selectedOption!;
                                            safeSetState(() {});

                                            await _model
                                                .usersRefOneQuestion!.reference
                                                .update({
                                              ...mapToFirestore(
                                                {
                                                  'wrongAnswers':
                                                      FieldValue.increment(1),
                                                },
                                              ),
                                            });
                                            // Navigation to wrong

                                            context.pushNamed(
                                                WrongAnswerQuizWidget
                                                    .routeName);
                                          }

                                          FFAppState().adCounter =
                                              FFAppState().adCounter + 1;

                                          safeSetState(() {});
                                        },
                                        text: 'Sprawdź poprawność pytania',
                                        options: FFButtonOptions(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.8,
                                          height: 50.0,
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16.0, 0.0, 16.0, 0.0),
                                          iconPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 0.0),
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          textStyle: FlutterFlowTheme.of(
                                                  context)
                                              .titleSmall
                                              .override(
                                                font: GoogleFonts.manrope(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmall
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmall
                                                          .fontStyle,
                                                ),
                                                color: Colors.white,
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .fontStyle,
                                              ),
                                          elevation: 0.0,
                                          borderRadius:
                                              BorderRadius.circular(24.0),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ).animateOnPageLoad(
                    animationsMap['columnOnPageLoadAnimation']!),
              ),
            ),
          ),
        );
      },
    );
  }
}
