import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/admob_util.dart' as admob;
import '/index.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'quiz_forty_answears_model.dart';
export 'quiz_forty_answears_model.dart';

class QuizFortyAnswearsWidget extends StatefulWidget {
  const QuizFortyAnswearsWidget({super.key});

  static String routeName = 'quizFortyAnswears';
  static String routePath = '/quizFortyAnswears';

  @override
  State<QuizFortyAnswearsWidget> createState() =>
      _QuizFortyAnswearsWidgetState();
}

class _QuizFortyAnswearsWidgetState extends State<QuizFortyAnswearsWidget> {
  late QuizFortyAnswearsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => QuizFortyAnswearsModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.correctAnswers = 0;
      _model.wrongAnswers = 0;
      _model.loopCounter = 0;
      _model.indexIDGrow = 0;
      safeSetState(() {});

      admob.loadInterstitialAd(
        "ca-app-pub-6394141425643906/6340471625",
        "ca-app-pub-6394141425643906/8408473013",
        false,
      );

      _model.usersRef = await queryUsersRecordOnce(
        queryBuilder: (usersRecord) => usersRecord.where(
          'email',
          isEqualTo: currentUserEmail,
        ),
        singleRecord: true,
      ).then((s) => s.firstOrNull);
      while (_model.loopCounter != 40) {
        _model.pytLoop = await queryQuizQuestionsRecordOnce(
          queryBuilder: (quizQuestionsRecord) => quizQuestionsRecord.where(
            'question_id',
            isEqualTo: valueOrDefault<int>(
              FFAppState()
                  .listOfQuestionsID
                  .elementAtOrNull(_model.indexIDGrow),
              0,
            ),
          ),
          singleRecord: true,
        ).then((s) => s.firstOrNull);
        if (FFAppState()
                .selectedOptionsForty
                .elementAtOrNull(_model.indexIDGrow) ==
            _model.pytLoop?.correctAnswerLetter) {
          _model.correctAnswers = _model.correctAnswers + 1;
          safeSetState(() {});

          await _model.usersRef!.reference.update({
            ...mapToFirestore(
              {
                'correctAnswers': FieldValue.increment(1),
              },
            ),
          });
        } else {
          _model.wrongAnswers = _model.wrongAnswers + 1;
          safeSetState(() {});

          await _model.usersRef!.reference.update({
            ...mapToFirestore(
              {
                'wrongAnswers': FieldValue.increment(1),
              },
            ),
          });
        }

        _model.loopCounter = _model.loopCounter + 1;
        _model.indexIDGrow = _model.indexIDGrow + 1;
        safeSetState(() {});
      }
      _model.percentageResult = valueOrDefault<int>(
        (_model.correctAnswers * 100 / 40).round(),
        0,
      );
      _model.adWatched = false;
      safeSetState(() {});
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

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                      child: Text(
                        'Wynik ${_model.correctAnswers >= 20 ? 'pozytywny' : 'negatywny'}',
                        textAlign: TextAlign.start,
                        style:
                            FlutterFlowTheme.of(context).displaySmall.override(
                                  font: GoogleFonts.outfit(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .displaySmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .displaySmall
                                        .fontStyle,
                                  ),
                                  color: _model.correctAnswers >= 20
                                      ? FlutterFlowTheme.of(context).tertiary
                                      : FlutterFlowTheme.of(context)
                                          .wrongAnswerBorder,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .displaySmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .displaySmall
                                      .fontStyle,
                                ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(12.0, 12.0, 12.0, 12.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 16.0),
                            child: Text(
                              'Poprawnych odpowiedzi: ${_model.correctAnswers.toString()}',
                              style: FlutterFlowTheme.of(context)
                                  .headlineSmall
                                  .override(
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
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 16.0),
                            child: Text(
                              'Błędnych odpowiedzi: ${_model.wrongAnswers.toString()}',
                              style: FlutterFlowTheme.of(context)
                                  .headlineSmall
                                  .override(
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
                          ),
                          Text(
                            'Wynik procentowy: ${_model.percentageResult.toString()}%',
                            style: FlutterFlowTheme.of(context)
                                .headlineSmall
                                .override(
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
                          if (valueOrDefault<bool>(
                                  currentUserDocument?.isUserPremium, false) ==
                              false)
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  12.0, 12.0, 12.0, 0.0),
                              child: AuthUserStreamWidget(
                                builder: (context) => FFButtonWidget(
                                  onPressed: () async {
                                    _model.interstitialAdSuccess =
                                        await admob.showInterstitialAd();

                                    if (_model.interstitialAdSuccess!) {
                                      _model.adWatched = true;
                                      safeSetState(() {});
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Coś poszło nie tak',
                                            style: FlutterFlowTheme.of(context)
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
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
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
                                          ),
                                          duration:
                                              Duration(milliseconds: 4000),
                                          backgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .error,
                                        ),
                                      );
                                    }

                                    safeSetState(() {});
                                  },
                                  text: 'Obejrzyj reklamę i zobacz wyjaśnienie',
                                  options: FFButtonOptions(
                                    height: 40.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: FlutterFlowTheme.of(context).primary,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          font: GoogleFonts.manrope(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
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
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              ),
                            ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 12.0, 12.0, 0.0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                _model.adWatched = false;
                                safeSetState(() {});

                                context.pushNamed(HomeWidget.routeName);
                              },
                              text: 'Powrót do menu głównego',
                              options: FFButtonOptions(
                                height: 40.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context).primary,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      font: GoogleFonts.manrope(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontStyle,
                                      ),
                                      color: Colors.white,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                    ),
                                elevation: 0.0,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                StreamBuilder<List<QuizQuestionsRecord>>(
                  stream: queryQuizQuestionsRecord(
                    queryBuilder: (quizQuestionsRecord) =>
                        quizQuestionsRecord.where(
                      'question_id',
                      isEqualTo:
                          FFAppState().listOfQuestionsID.elementAtOrNull(0),
                    ),
                    singleRecord: true,
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: SpinKitFoldingCube(
                            color: FlutterFlowTheme.of(context).primary,
                            size: 50.0,
                          ),
                        ),
                      );
                    }
                    List<QuizQuestionsRecord> row1QuizQuestionsRecordList =
                        snapshot.data!;
                    // Return an empty Container when the item does not exist.
                    if (snapshot.data!.isEmpty) {
                      return Container();
                    }
                    final row1QuizQuestionsRecord =
                        row1QuizQuestionsRecordList.isNotEmpty
                            ? row1QuizQuestionsRecordList.first
                            : null;

                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 12.0, 16.0, 8.0),
                            child: Container(
                              width: 100.0,
                              decoration: BoxDecoration(
                                color: FFAppState()
                                            .selectedOptionsForty
                                            .elementAtOrNull(0) ==
                                        row1QuizQuestionsRecord
                                            ?.correctAnswerLetter
                                    ? FlutterFlowTheme.of(context)
                                        .correctWithOpacity
                                    : FlutterFlowTheme.of(context)
                                        .wrongAnswerBackground,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15.0),
                                  bottomRight: Radius.circular(15.0),
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                                border: Border.all(
                                  color: FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(0) ==
                                          row1QuizQuestionsRecord
                                              ?.correctAnswerLetter
                                      ? FlutterFlowTheme.of(context).tertiary
                                      : FlutterFlowTheme.of(context)
                                          .wrongAnswerBorder,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      () {
                                        if (row1QuizQuestionsRecord
                                                ?.correctAnswerLetter ==
                                            FFAppState()
                                                .selectedOptionsForty
                                                .elementAtOrNull(0)) {
                                          return 'Poprawna odpowiedź';
                                        } else if (FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(0) ==
                                                null ||
                                            FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(0) ==
                                                '') {
                                          return 'Brak odpowiedzi';
                                        } else {
                                          return 'Błędna odpowiedź';
                                        }
                                      }(),
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      'Treść pytania: ${row1QuizQuestionsRecord?.description}',
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  if (row1QuizQuestionsRecord?.questionPhoto !=
                                          null &&
                                      row1QuizQuestionsRecord?.questionPhoto !=
                                          '')
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
                                              child:
                                                  FlutterFlowExpandedImageView(
                                                image: Image.network(
                                                  row1QuizQuestionsRecord
                                                      .questionPhoto,
                                                  fit: BoxFit.contain,
                                                ),
                                                allowRotation: false,
                                                tag: row1QuizQuestionsRecord
                                                    .questionPhoto,
                                                useHeroAnimation: true,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Hero(
                                          tag: row1QuizQuestionsRecord!
                                              .questionPhoto,
                                          transitionOnUserGestures: true,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              row1QuizQuestionsRecord
                                                  .questionPhoto,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if ((FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(0) !=
                                          row1QuizQuestionsRecord
                                              ?.correctAnswerLetter) &&
                                      (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(0) !=
                                              null &&
                                          FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(0) !=
                                              ''))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Twoja odpowiedź: ${FFAppState().selectedOptionsForty.elementAtOrNull(0)}. ${row1QuizQuestionsRecord?.options.elementAtOrNull(() {
                                          if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(0) ==
                                              'A') {
                                            return 0;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(0) ==
                                              'B') {
                                            return 1;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(0) ==
                                              'C') {
                                            return 2;
                                          } else {
                                            return 3;
                                          }
                                        }())}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if (FFAppState()
                                          .selectedOptionsForty
                                          .elementAtOrNull(0) !=
                                      row1QuizQuestionsRecord
                                          ?.correctAnswerLetter)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Poprawna odpowiedź: ${row1QuizQuestionsRecord?.correctAnswerLetter}. ${row1QuizQuestionsRecord?.correctAnswer}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if ((valueOrDefault<bool>(
                                              currentUserDocument
                                                  ?.isUserPremium,
                                              false) ==
                                          true) ||
                                      ((valueOrDefault<bool>(
                                                  currentUserDocument
                                                      ?.isUserPremium,
                                                  false) ==
                                              false) &&
                                          (_model.adWatched == true)))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 12.0),
                                      child: AuthUserStreamWidget(
                                        builder: (context) => Text(
                                          'Wyjaśnienie: ${row1QuizQuestionsRecord?.explenation}',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.manrope(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
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
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                StreamBuilder<List<QuizQuestionsRecord>>(
                  stream: queryQuizQuestionsRecord(
                    queryBuilder: (quizQuestionsRecord) =>
                        quizQuestionsRecord.where(
                      'question_id',
                      isEqualTo:
                          FFAppState().listOfQuestionsID.elementAtOrNull(1),
                    ),
                    singleRecord: true,
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: SpinKitFoldingCube(
                            color: FlutterFlowTheme.of(context).primary,
                            size: 50.0,
                          ),
                        ),
                      );
                    }
                    List<QuizQuestionsRecord> row2QuizQuestionsRecordList =
                        snapshot.data!;
                    // Return an empty Container when the item does not exist.
                    if (snapshot.data!.isEmpty) {
                      return Container();
                    }
                    final row2QuizQuestionsRecord =
                        row2QuizQuestionsRecordList.isNotEmpty
                            ? row2QuizQuestionsRecordList.first
                            : null;

                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 12.0, 16.0, 8.0),
                            child: Container(
                              width: 100.0,
                              decoration: BoxDecoration(
                                color: FFAppState()
                                            .selectedOptionsForty
                                            .elementAtOrNull(1) ==
                                        row2QuizQuestionsRecord
                                            ?.correctAnswerLetter
                                    ? FlutterFlowTheme.of(context)
                                        .correctWithOpacity
                                    : FlutterFlowTheme.of(context)
                                        .wrongAnswerBackground,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15.0),
                                  bottomRight: Radius.circular(15.0),
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                                border: Border.all(
                                  color: FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(1) ==
                                          row2QuizQuestionsRecord
                                              ?.correctAnswerLetter
                                      ? FlutterFlowTheme.of(context).tertiary
                                      : FlutterFlowTheme.of(context)
                                          .wrongAnswerBorder,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      () {
                                        if (row2QuizQuestionsRecord
                                                ?.correctAnswerLetter ==
                                            FFAppState()
                                                .selectedOptionsForty
                                                .elementAtOrNull(1)) {
                                          return 'Poprawna odpowiedź';
                                        } else if (FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(1) ==
                                                null ||
                                            FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(1) ==
                                                '') {
                                          return 'Brak odpowiedzi';
                                        } else {
                                          return 'Błędna odpowiedź';
                                        }
                                      }(),
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      'Treść pytania: ${row2QuizQuestionsRecord?.description}',
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  if (row2QuizQuestionsRecord?.questionPhoto !=
                                          null &&
                                      row2QuizQuestionsRecord?.questionPhoto !=
                                          '')
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
                                              child:
                                                  FlutterFlowExpandedImageView(
                                                image: Image.network(
                                                  row2QuizQuestionsRecord
                                                      .questionPhoto,
                                                  fit: BoxFit.contain,
                                                ),
                                                allowRotation: false,
                                                tag: row2QuizQuestionsRecord
                                                    .questionPhoto,
                                                useHeroAnimation: true,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Hero(
                                          tag: row2QuizQuestionsRecord!
                                              .questionPhoto,
                                          transitionOnUserGestures: true,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              row2QuizQuestionsRecord
                                                  .questionPhoto,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if ((FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(1) !=
                                          row2QuizQuestionsRecord
                                              ?.correctAnswerLetter) &&
                                      (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(1) !=
                                              null &&
                                          FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(1) !=
                                              ''))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Twoja odpowiedź: ${FFAppState().selectedOptionsForty.elementAtOrNull(1)}. ${row2QuizQuestionsRecord?.options.elementAtOrNull(() {
                                          if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(1) ==
                                              'A') {
                                            return 0;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(1) ==
                                              'B') {
                                            return 1;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(1) ==
                                              'C') {
                                            return 2;
                                          } else {
                                            return 3;
                                          }
                                        }())}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if (FFAppState()
                                          .selectedOptionsForty
                                          .elementAtOrNull(1) !=
                                      row2QuizQuestionsRecord
                                          ?.correctAnswerLetter)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Poprawna odpowiedź: ${row2QuizQuestionsRecord?.correctAnswerLetter}. ${row2QuizQuestionsRecord?.correctAnswer}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if ((valueOrDefault<bool>(
                                              currentUserDocument
                                                  ?.isUserPremium,
                                              false) ==
                                          true) ||
                                      ((valueOrDefault<bool>(
                                                  currentUserDocument
                                                      ?.isUserPremium,
                                                  false) ==
                                              false) &&
                                          (_model.adWatched == true)))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 12.0),
                                      child: AuthUserStreamWidget(
                                        builder: (context) => Text(
                                          'Wyjaśnienie: ${row2QuizQuestionsRecord?.explenation}',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.manrope(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
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
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                StreamBuilder<List<QuizQuestionsRecord>>(
                  stream: queryQuizQuestionsRecord(
                    queryBuilder: (quizQuestionsRecord) =>
                        quizQuestionsRecord.where(
                      'question_id',
                      isEqualTo:
                          FFAppState().listOfQuestionsID.elementAtOrNull(2),
                    ),
                    singleRecord: true,
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: SpinKitFoldingCube(
                            color: FlutterFlowTheme.of(context).primary,
                            size: 50.0,
                          ),
                        ),
                      );
                    }
                    List<QuizQuestionsRecord> row3QuizQuestionsRecordList =
                        snapshot.data!;
                    // Return an empty Container when the item does not exist.
                    if (snapshot.data!.isEmpty) {
                      return Container();
                    }
                    final row3QuizQuestionsRecord =
                        row3QuizQuestionsRecordList.isNotEmpty
                            ? row3QuizQuestionsRecordList.first
                            : null;

                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 12.0, 16.0, 8.0),
                            child: Container(
                              width: 100.0,
                              decoration: BoxDecoration(
                                color: FFAppState()
                                            .selectedOptionsForty
                                            .elementAtOrNull(2) ==
                                        row3QuizQuestionsRecord
                                            ?.correctAnswerLetter
                                    ? FlutterFlowTheme.of(context)
                                        .correctWithOpacity
                                    : FlutterFlowTheme.of(context)
                                        .wrongAnswerBackground,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15.0),
                                  bottomRight: Radius.circular(15.0),
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                                border: Border.all(
                                  color: FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(2) ==
                                          row3QuizQuestionsRecord
                                              ?.correctAnswerLetter
                                      ? FlutterFlowTheme.of(context).tertiary
                                      : FlutterFlowTheme.of(context)
                                          .wrongAnswerBorder,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      () {
                                        if (row3QuizQuestionsRecord
                                                ?.correctAnswerLetter ==
                                            FFAppState()
                                                .selectedOptionsForty
                                                .elementAtOrNull(2)) {
                                          return 'Poprawna odpowiedź';
                                        } else if (FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(2) ==
                                                null ||
                                            FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(2) ==
                                                '') {
                                          return 'Brak odpowiedzi';
                                        } else {
                                          return 'Błędna odpowiedź';
                                        }
                                      }(),
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      'Treść pytania: ${row3QuizQuestionsRecord?.description}',
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  if (row3QuizQuestionsRecord?.questionPhoto !=
                                          null &&
                                      row3QuizQuestionsRecord?.questionPhoto !=
                                          '')
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
                                              child:
                                                  FlutterFlowExpandedImageView(
                                                image: Image.network(
                                                  row3QuizQuestionsRecord
                                                      .questionPhoto,
                                                  fit: BoxFit.contain,
                                                ),
                                                allowRotation: false,
                                                tag: row3QuizQuestionsRecord
                                                    .questionPhoto,
                                                useHeroAnimation: true,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Hero(
                                          tag: row3QuizQuestionsRecord!
                                              .questionPhoto,
                                          transitionOnUserGestures: true,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              row3QuizQuestionsRecord
                                                  .questionPhoto,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if ((FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(2) !=
                                          row3QuizQuestionsRecord
                                              ?.correctAnswerLetter) &&
                                      (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(2) !=
                                              null &&
                                          FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(2) !=
                                              ''))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Twoja odpowiedź: ${FFAppState().selectedOptionsForty.elementAtOrNull(2)}. ${row3QuizQuestionsRecord?.options.elementAtOrNull(() {
                                          if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(2) ==
                                              'A') {
                                            return 0;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(2) ==
                                              'B') {
                                            return 1;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(2) ==
                                              'C') {
                                            return 2;
                                          } else {
                                            return 3;
                                          }
                                        }())}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if (FFAppState()
                                          .selectedOptionsForty
                                          .elementAtOrNull(2) !=
                                      row3QuizQuestionsRecord
                                          ?.correctAnswerLetter)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Poprawna odpowiedź: ${row3QuizQuestionsRecord?.correctAnswerLetter}. ${row3QuizQuestionsRecord?.correctAnswer}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if ((valueOrDefault<bool>(
                                              currentUserDocument
                                                  ?.isUserPremium,
                                              false) ==
                                          true) ||
                                      ((valueOrDefault<bool>(
                                                  currentUserDocument
                                                      ?.isUserPremium,
                                                  false) ==
                                              false) &&
                                          (_model.adWatched == true)))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 12.0),
                                      child: AuthUserStreamWidget(
                                        builder: (context) => Text(
                                          'Wyjaśnienie: ${row3QuizQuestionsRecord?.explenation}',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.manrope(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
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
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                StreamBuilder<List<QuizQuestionsRecord>>(
                  stream: queryQuizQuestionsRecord(
                    queryBuilder: (quizQuestionsRecord) =>
                        quizQuestionsRecord.where(
                      'question_id',
                      isEqualTo:
                          FFAppState().listOfQuestionsID.elementAtOrNull(3),
                    ),
                    singleRecord: true,
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: SpinKitFoldingCube(
                            color: FlutterFlowTheme.of(context).primary,
                            size: 50.0,
                          ),
                        ),
                      );
                    }
                    List<QuizQuestionsRecord> row4QuizQuestionsRecordList =
                        snapshot.data!;
                    // Return an empty Container when the item does not exist.
                    if (snapshot.data!.isEmpty) {
                      return Container();
                    }
                    final row4QuizQuestionsRecord =
                        row4QuizQuestionsRecordList.isNotEmpty
                            ? row4QuizQuestionsRecordList.first
                            : null;

                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 12.0, 16.0, 8.0),
                            child: Container(
                              width: 100.0,
                              decoration: BoxDecoration(
                                color: FFAppState()
                                            .selectedOptionsForty
                                            .elementAtOrNull(3) ==
                                        row4QuizQuestionsRecord
                                            ?.correctAnswerLetter
                                    ? FlutterFlowTheme.of(context)
                                        .correctWithOpacity
                                    : FlutterFlowTheme.of(context)
                                        .wrongAnswerBackground,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15.0),
                                  bottomRight: Radius.circular(15.0),
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                                border: Border.all(
                                  color: FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(3) ==
                                          row4QuizQuestionsRecord
                                              ?.correctAnswerLetter
                                      ? FlutterFlowTheme.of(context).tertiary
                                      : FlutterFlowTheme.of(context)
                                          .wrongAnswerBorder,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      () {
                                        if (row4QuizQuestionsRecord
                                                ?.correctAnswerLetter ==
                                            FFAppState()
                                                .selectedOptionsForty
                                                .elementAtOrNull(3)) {
                                          return 'Poprawna odpowiedź';
                                        } else if (FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(3) ==
                                                null ||
                                            FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(3) ==
                                                '') {
                                          return 'Brak odpowiedzi';
                                        } else {
                                          return 'Błędna odpowiedź';
                                        }
                                      }(),
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      'Treść pytania: ${row4QuizQuestionsRecord?.description}',
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  if (row4QuizQuestionsRecord?.questionPhoto !=
                                          null &&
                                      row4QuizQuestionsRecord?.questionPhoto !=
                                          '')
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
                                              child:
                                                  FlutterFlowExpandedImageView(
                                                image: Image.network(
                                                  row4QuizQuestionsRecord
                                                      .questionPhoto,
                                                  fit: BoxFit.contain,
                                                ),
                                                allowRotation: false,
                                                tag: row4QuizQuestionsRecord
                                                    .questionPhoto,
                                                useHeroAnimation: true,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Hero(
                                          tag: row4QuizQuestionsRecord!
                                              .questionPhoto,
                                          transitionOnUserGestures: true,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              row4QuizQuestionsRecord
                                                  .questionPhoto,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if ((FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(3) !=
                                          row4QuizQuestionsRecord
                                              ?.correctAnswerLetter) &&
                                      (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(3) !=
                                              null &&
                                          FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(3) !=
                                              ''))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Twoja odpowiedź: ${FFAppState().selectedOptionsForty.elementAtOrNull(3)}. ${row4QuizQuestionsRecord?.options.elementAtOrNull(() {
                                          if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(3) ==
                                              'A') {
                                            return 0;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(3) ==
                                              'B') {
                                            return 1;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(3) ==
                                              'C') {
                                            return 2;
                                          } else {
                                            return 3;
                                          }
                                        }())}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if (FFAppState()
                                          .selectedOptionsForty
                                          .elementAtOrNull(3) !=
                                      row4QuizQuestionsRecord
                                          ?.correctAnswerLetter)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Poprawna odpowiedź: ${row4QuizQuestionsRecord?.correctAnswerLetter}. ${row4QuizQuestionsRecord?.correctAnswer}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if ((valueOrDefault<bool>(
                                              currentUserDocument
                                                  ?.isUserPremium,
                                              false) ==
                                          true) ||
                                      ((valueOrDefault<bool>(
                                                  currentUserDocument
                                                      ?.isUserPremium,
                                                  false) ==
                                              false) &&
                                          (_model.adWatched == true)))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 12.0),
                                      child: AuthUserStreamWidget(
                                        builder: (context) => Text(
                                          'Wyjaśnienie: ${row4QuizQuestionsRecord?.explenation}',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.manrope(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
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
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                StreamBuilder<List<QuizQuestionsRecord>>(
                  stream: queryQuizQuestionsRecord(
                    queryBuilder: (quizQuestionsRecord) =>
                        quizQuestionsRecord.where(
                      'question_id',
                      isEqualTo:
                          FFAppState().listOfQuestionsID.elementAtOrNull(4),
                    ),
                    singleRecord: true,
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: SpinKitFoldingCube(
                            color: FlutterFlowTheme.of(context).primary,
                            size: 50.0,
                          ),
                        ),
                      );
                    }
                    List<QuizQuestionsRecord> row5QuizQuestionsRecordList =
                        snapshot.data!;
                    // Return an empty Container when the item does not exist.
                    if (snapshot.data!.isEmpty) {
                      return Container();
                    }
                    final row5QuizQuestionsRecord =
                        row5QuizQuestionsRecordList.isNotEmpty
                            ? row5QuizQuestionsRecordList.first
                            : null;

                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 12.0, 16.0, 8.0),
                            child: Container(
                              width: 100.0,
                              decoration: BoxDecoration(
                                color: FFAppState()
                                            .selectedOptionsForty
                                            .elementAtOrNull(4) ==
                                        row5QuizQuestionsRecord
                                            ?.correctAnswerLetter
                                    ? FlutterFlowTheme.of(context)
                                        .correctWithOpacity
                                    : FlutterFlowTheme.of(context)
                                        .wrongAnswerBackground,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15.0),
                                  bottomRight: Radius.circular(15.0),
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                                border: Border.all(
                                  color: FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(4) ==
                                          row5QuizQuestionsRecord
                                              ?.correctAnswerLetter
                                      ? FlutterFlowTheme.of(context).tertiary
                                      : FlutterFlowTheme.of(context)
                                          .wrongAnswerBorder,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      () {
                                        if (row5QuizQuestionsRecord
                                                ?.correctAnswerLetter ==
                                            FFAppState()
                                                .selectedOptionsForty
                                                .elementAtOrNull(4)) {
                                          return 'Poprawna odpowiedź';
                                        } else if (FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(4) ==
                                                null ||
                                            FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(4) ==
                                                '') {
                                          return 'Brak odpowiedzi';
                                        } else {
                                          return 'Błędna odpowiedź';
                                        }
                                      }(),
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      'Treść pytania: ${row5QuizQuestionsRecord?.description}',
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  if (row5QuizQuestionsRecord?.questionPhoto !=
                                          null &&
                                      row5QuizQuestionsRecord?.questionPhoto !=
                                          '')
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
                                              child:
                                                  FlutterFlowExpandedImageView(
                                                image: Image.network(
                                                  row5QuizQuestionsRecord
                                                      .questionPhoto,
                                                  fit: BoxFit.contain,
                                                ),
                                                allowRotation: false,
                                                tag: row5QuizQuestionsRecord
                                                    .questionPhoto,
                                                useHeroAnimation: true,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Hero(
                                          tag: row5QuizQuestionsRecord!
                                              .questionPhoto,
                                          transitionOnUserGestures: true,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              row5QuizQuestionsRecord
                                                  .questionPhoto,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if ((FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(4) !=
                                          row5QuizQuestionsRecord
                                              ?.correctAnswerLetter) &&
                                      (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(4) !=
                                              null &&
                                          FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(4) !=
                                              ''))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Twoja odpowiedź: ${FFAppState().selectedOptionsForty.elementAtOrNull(4)}. ${row5QuizQuestionsRecord?.options.elementAtOrNull(() {
                                          if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(4) ==
                                              'A') {
                                            return 0;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(4) ==
                                              'B') {
                                            return 1;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(4) ==
                                              'C') {
                                            return 2;
                                          } else {
                                            return 3;
                                          }
                                        }())}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if (FFAppState()
                                          .selectedOptionsForty
                                          .elementAtOrNull(4) !=
                                      row5QuizQuestionsRecord
                                          ?.correctAnswerLetter)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Poprawna odpowiedź: ${row5QuizQuestionsRecord?.correctAnswerLetter}. ${row5QuizQuestionsRecord?.correctAnswer}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if ((valueOrDefault<bool>(
                                              currentUserDocument
                                                  ?.isUserPremium,
                                              false) ==
                                          true) ||
                                      ((valueOrDefault<bool>(
                                                  currentUserDocument
                                                      ?.isUserPremium,
                                                  false) ==
                                              false) &&
                                          (_model.adWatched == true)))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 12.0),
                                      child: AuthUserStreamWidget(
                                        builder: (context) => Text(
                                          'Wyjaśnienie: ${row5QuizQuestionsRecord?.explenation}',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.manrope(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
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
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                StreamBuilder<List<QuizQuestionsRecord>>(
                  stream: queryQuizQuestionsRecord(
                    queryBuilder: (quizQuestionsRecord) =>
                        quizQuestionsRecord.where(
                      'question_id',
                      isEqualTo:
                          FFAppState().listOfQuestionsID.elementAtOrNull(5),
                    ),
                    singleRecord: true,
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: SpinKitFoldingCube(
                            color: FlutterFlowTheme.of(context).primary,
                            size: 50.0,
                          ),
                        ),
                      );
                    }
                    List<QuizQuestionsRecord> row6QuizQuestionsRecordList =
                        snapshot.data!;
                    // Return an empty Container when the item does not exist.
                    if (snapshot.data!.isEmpty) {
                      return Container();
                    }
                    final row6QuizQuestionsRecord =
                        row6QuizQuestionsRecordList.isNotEmpty
                            ? row6QuizQuestionsRecordList.first
                            : null;

                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 12.0, 16.0, 8.0),
                            child: Container(
                              width: 100.0,
                              decoration: BoxDecoration(
                                color: FFAppState()
                                            .selectedOptionsForty
                                            .elementAtOrNull(5) ==
                                        row6QuizQuestionsRecord
                                            ?.correctAnswerLetter
                                    ? FlutterFlowTheme.of(context)
                                        .correctWithOpacity
                                    : FlutterFlowTheme.of(context)
                                        .wrongAnswerBackground,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15.0),
                                  bottomRight: Radius.circular(15.0),
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                                border: Border.all(
                                  color: FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(5) ==
                                          row6QuizQuestionsRecord
                                              ?.correctAnswerLetter
                                      ? FlutterFlowTheme.of(context).tertiary
                                      : FlutterFlowTheme.of(context)
                                          .wrongAnswerBorder,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      () {
                                        if (row6QuizQuestionsRecord
                                                ?.correctAnswerLetter ==
                                            FFAppState()
                                                .selectedOptionsForty
                                                .elementAtOrNull(5)) {
                                          return 'Poprawna odpowiedź';
                                        } else if (FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(5) ==
                                                null ||
                                            FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(5) ==
                                                '') {
                                          return 'Brak odpowiedzi';
                                        } else {
                                          return 'Błędna odpowiedź';
                                        }
                                      }(),
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      'Treść pytania: ${row6QuizQuestionsRecord?.description}',
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  if (row6QuizQuestionsRecord?.questionPhoto !=
                                          null &&
                                      row6QuizQuestionsRecord?.questionPhoto !=
                                          '')
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
                                              child:
                                                  FlutterFlowExpandedImageView(
                                                image: Image.network(
                                                  row6QuizQuestionsRecord
                                                      .questionPhoto,
                                                  fit: BoxFit.contain,
                                                ),
                                                allowRotation: false,
                                                tag: row6QuizQuestionsRecord
                                                    .questionPhoto,
                                                useHeroAnimation: true,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Hero(
                                          tag: row6QuizQuestionsRecord!
                                              .questionPhoto,
                                          transitionOnUserGestures: true,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              row6QuizQuestionsRecord
                                                  .questionPhoto,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if ((FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(5) !=
                                          row6QuizQuestionsRecord
                                              ?.correctAnswerLetter) &&
                                      (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(5) !=
                                              null &&
                                          FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(5) !=
                                              ''))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Twoja odpowiedź: ${FFAppState().selectedOptionsForty.elementAtOrNull(5)}. ${row6QuizQuestionsRecord?.options.elementAtOrNull(() {
                                          if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(5) ==
                                              'A') {
                                            return 0;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(5) ==
                                              'B') {
                                            return 1;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(5) ==
                                              'C') {
                                            return 2;
                                          } else {
                                            return 3;
                                          }
                                        }())}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if (FFAppState()
                                          .selectedOptionsForty
                                          .elementAtOrNull(5) !=
                                      row6QuizQuestionsRecord
                                          ?.correctAnswerLetter)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Poprawna odpowiedź: ${row6QuizQuestionsRecord?.correctAnswerLetter}. ${row6QuizQuestionsRecord?.correctAnswer}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if ((valueOrDefault<bool>(
                                              currentUserDocument
                                                  ?.isUserPremium,
                                              false) ==
                                          true) ||
                                      ((valueOrDefault<bool>(
                                                  currentUserDocument
                                                      ?.isUserPremium,
                                                  false) ==
                                              false) &&
                                          (_model.adWatched == true)))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 12.0),
                                      child: AuthUserStreamWidget(
                                        builder: (context) => Text(
                                          'Wyjaśnienie: ${row6QuizQuestionsRecord?.explenation}',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.manrope(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
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
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                StreamBuilder<List<QuizQuestionsRecord>>(
                  stream: queryQuizQuestionsRecord(
                    queryBuilder: (quizQuestionsRecord) =>
                        quizQuestionsRecord.where(
                      'question_id',
                      isEqualTo:
                          FFAppState().listOfQuestionsID.elementAtOrNull(6),
                    ),
                    singleRecord: true,
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: SpinKitFoldingCube(
                            color: FlutterFlowTheme.of(context).primary,
                            size: 50.0,
                          ),
                        ),
                      );
                    }
                    List<QuizQuestionsRecord> row7QuizQuestionsRecordList =
                        snapshot.data!;
                    // Return an empty Container when the item does not exist.
                    if (snapshot.data!.isEmpty) {
                      return Container();
                    }
                    final row7QuizQuestionsRecord =
                        row7QuizQuestionsRecordList.isNotEmpty
                            ? row7QuizQuestionsRecordList.first
                            : null;

                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 12.0, 16.0, 8.0),
                            child: Container(
                              width: 100.0,
                              decoration: BoxDecoration(
                                color: FFAppState()
                                            .selectedOptionsForty
                                            .elementAtOrNull(6) ==
                                        row7QuizQuestionsRecord
                                            ?.correctAnswerLetter
                                    ? FlutterFlowTheme.of(context)
                                        .correctWithOpacity
                                    : FlutterFlowTheme.of(context)
                                        .wrongAnswerBackground,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15.0),
                                  bottomRight: Radius.circular(15.0),
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                                border: Border.all(
                                  color: FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(6) ==
                                          row7QuizQuestionsRecord
                                              ?.correctAnswerLetter
                                      ? FlutterFlowTheme.of(context).tertiary
                                      : FlutterFlowTheme.of(context)
                                          .wrongAnswerBorder,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      () {
                                        if (row7QuizQuestionsRecord
                                                ?.correctAnswerLetter ==
                                            FFAppState()
                                                .selectedOptionsForty
                                                .elementAtOrNull(6)) {
                                          return 'Poprawna odpowiedź';
                                        } else if (FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(6) ==
                                                null ||
                                            FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(6) ==
                                                '') {
                                          return 'Brak odpowiedzi';
                                        } else {
                                          return 'Błędna odpowiedź';
                                        }
                                      }(),
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      'Treść pytania: ${row7QuizQuestionsRecord?.description}',
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  if (row7QuizQuestionsRecord?.questionPhoto !=
                                          null &&
                                      row7QuizQuestionsRecord?.questionPhoto !=
                                          '')
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
                                              child:
                                                  FlutterFlowExpandedImageView(
                                                image: Image.network(
                                                  row7QuizQuestionsRecord
                                                      .questionPhoto,
                                                  fit: BoxFit.contain,
                                                ),
                                                allowRotation: false,
                                                tag: row7QuizQuestionsRecord
                                                    .questionPhoto,
                                                useHeroAnimation: true,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Hero(
                                          tag: row7QuizQuestionsRecord!
                                              .questionPhoto,
                                          transitionOnUserGestures: true,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              row7QuizQuestionsRecord
                                                  .questionPhoto,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if ((FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(6) !=
                                          row7QuizQuestionsRecord
                                              ?.correctAnswerLetter) &&
                                      (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(6) !=
                                              null &&
                                          FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(6) !=
                                              ''))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Twoja odpowiedź: ${FFAppState().selectedOptionsForty.elementAtOrNull(6)}. ${row7QuizQuestionsRecord?.options.elementAtOrNull(() {
                                          if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(6) ==
                                              'A') {
                                            return 0;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(6) ==
                                              'B') {
                                            return 1;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(6) ==
                                              'C') {
                                            return 2;
                                          } else {
                                            return 3;
                                          }
                                        }())}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if (FFAppState()
                                          .selectedOptionsForty
                                          .elementAtOrNull(6) !=
                                      row7QuizQuestionsRecord
                                          ?.correctAnswerLetter)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Poprawna odpowiedź: ${row7QuizQuestionsRecord?.correctAnswerLetter}. ${row7QuizQuestionsRecord?.correctAnswer}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if ((valueOrDefault<bool>(
                                              currentUserDocument
                                                  ?.isUserPremium,
                                              false) ==
                                          true) ||
                                      ((valueOrDefault<bool>(
                                                  currentUserDocument
                                                      ?.isUserPremium,
                                                  false) ==
                                              false) &&
                                          (_model.adWatched == true)))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 12.0),
                                      child: AuthUserStreamWidget(
                                        builder: (context) => Text(
                                          'Wyjaśnienie: ${row7QuizQuestionsRecord?.explenation}',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.manrope(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
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
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                StreamBuilder<List<QuizQuestionsRecord>>(
                  stream: queryQuizQuestionsRecord(
                    queryBuilder: (quizQuestionsRecord) =>
                        quizQuestionsRecord.where(
                      'question_id',
                      isEqualTo:
                          FFAppState().listOfQuestionsID.elementAtOrNull(7),
                    ),
                    singleRecord: true,
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: SpinKitFoldingCube(
                            color: FlutterFlowTheme.of(context).primary,
                            size: 50.0,
                          ),
                        ),
                      );
                    }
                    List<QuizQuestionsRecord> row8QuizQuestionsRecordList =
                        snapshot.data!;
                    // Return an empty Container when the item does not exist.
                    if (snapshot.data!.isEmpty) {
                      return Container();
                    }
                    final row8QuizQuestionsRecord =
                        row8QuizQuestionsRecordList.isNotEmpty
                            ? row8QuizQuestionsRecordList.first
                            : null;

                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 12.0, 16.0, 8.0),
                            child: Container(
                              width: 100.0,
                              decoration: BoxDecoration(
                                color: FFAppState()
                                            .selectedOptionsForty
                                            .elementAtOrNull(7) ==
                                        row8QuizQuestionsRecord
                                            ?.correctAnswerLetter
                                    ? FlutterFlowTheme.of(context)
                                        .correctWithOpacity
                                    : FlutterFlowTheme.of(context)
                                        .wrongAnswerBackground,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15.0),
                                  bottomRight: Radius.circular(15.0),
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                                border: Border.all(
                                  color: FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(7) ==
                                          row8QuizQuestionsRecord
                                              ?.correctAnswerLetter
                                      ? FlutterFlowTheme.of(context).tertiary
                                      : FlutterFlowTheme.of(context)
                                          .wrongAnswerBorder,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      () {
                                        if (row8QuizQuestionsRecord
                                                ?.correctAnswerLetter ==
                                            FFAppState()
                                                .selectedOptionsForty
                                                .elementAtOrNull(7)) {
                                          return 'Poprawna odpowiedź';
                                        } else if (FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(7) ==
                                                null ||
                                            FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(7) ==
                                                '') {
                                          return 'Brak odpowiedzi';
                                        } else {
                                          return 'Błędna odpowiedź';
                                        }
                                      }(),
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      'Treść pytania: ${row8QuizQuestionsRecord?.description}',
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  if (row8QuizQuestionsRecord?.questionPhoto !=
                                          null &&
                                      row8QuizQuestionsRecord?.questionPhoto !=
                                          '')
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
                                              child:
                                                  FlutterFlowExpandedImageView(
                                                image: Image.network(
                                                  row8QuizQuestionsRecord
                                                      .questionPhoto,
                                                  fit: BoxFit.contain,
                                                ),
                                                allowRotation: false,
                                                tag: row8QuizQuestionsRecord
                                                    .questionPhoto,
                                                useHeroAnimation: true,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Hero(
                                          tag: row8QuizQuestionsRecord!
                                              .questionPhoto,
                                          transitionOnUserGestures: true,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              row8QuizQuestionsRecord
                                                  .questionPhoto,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if ((FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(7) !=
                                          row8QuizQuestionsRecord
                                              ?.correctAnswerLetter) &&
                                      (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(7) !=
                                              null &&
                                          FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(7) !=
                                              ''))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Twoja odpowiedź: ${FFAppState().selectedOptionsForty.elementAtOrNull(7)}. ${row8QuizQuestionsRecord?.options.elementAtOrNull(() {
                                          if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(7) ==
                                              'A') {
                                            return 0;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(7) ==
                                              'B') {
                                            return 1;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(7) ==
                                              'C') {
                                            return 2;
                                          } else {
                                            return 3;
                                          }
                                        }())}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if (FFAppState()
                                          .selectedOptionsForty
                                          .elementAtOrNull(7) !=
                                      row8QuizQuestionsRecord
                                          ?.correctAnswerLetter)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Poprawna odpowiedź: ${row8QuizQuestionsRecord?.correctAnswerLetter}. ${row8QuizQuestionsRecord?.correctAnswer}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if ((valueOrDefault<bool>(
                                              currentUserDocument
                                                  ?.isUserPremium,
                                              false) ==
                                          true) ||
                                      ((valueOrDefault<bool>(
                                                  currentUserDocument
                                                      ?.isUserPremium,
                                                  false) ==
                                              false) &&
                                          (_model.adWatched == true)))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 12.0),
                                      child: AuthUserStreamWidget(
                                        builder: (context) => Text(
                                          'Wyjaśnienie: ${row8QuizQuestionsRecord?.explenation}',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.manrope(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
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
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                StreamBuilder<List<QuizQuestionsRecord>>(
                  stream: queryQuizQuestionsRecord(
                    queryBuilder: (quizQuestionsRecord) =>
                        quizQuestionsRecord.where(
                      'question_id',
                      isEqualTo:
                          FFAppState().listOfQuestionsID.elementAtOrNull(8),
                    ),
                    singleRecord: true,
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: SpinKitFoldingCube(
                            color: FlutterFlowTheme.of(context).primary,
                            size: 50.0,
                          ),
                        ),
                      );
                    }
                    List<QuizQuestionsRecord> row9QuizQuestionsRecordList =
                        snapshot.data!;
                    // Return an empty Container when the item does not exist.
                    if (snapshot.data!.isEmpty) {
                      return Container();
                    }
                    final row9QuizQuestionsRecord =
                        row9QuizQuestionsRecordList.isNotEmpty
                            ? row9QuizQuestionsRecordList.first
                            : null;

                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 12.0, 16.0, 8.0),
                            child: Container(
                              width: 100.0,
                              decoration: BoxDecoration(
                                color: FFAppState()
                                            .selectedOptionsForty
                                            .elementAtOrNull(8) ==
                                        row9QuizQuestionsRecord
                                            ?.correctAnswerLetter
                                    ? FlutterFlowTheme.of(context)
                                        .correctWithOpacity
                                    : FlutterFlowTheme.of(context)
                                        .wrongAnswerBackground,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15.0),
                                  bottomRight: Radius.circular(15.0),
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                                border: Border.all(
                                  color: FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(8) ==
                                          row9QuizQuestionsRecord
                                              ?.correctAnswerLetter
                                      ? FlutterFlowTheme.of(context).tertiary
                                      : FlutterFlowTheme.of(context)
                                          .wrongAnswerBorder,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      () {
                                        if (row9QuizQuestionsRecord
                                                ?.correctAnswerLetter ==
                                            FFAppState()
                                                .selectedOptionsForty
                                                .elementAtOrNull(8)) {
                                          return 'Poprawna odpowiedź';
                                        } else if (FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(8) ==
                                                null ||
                                            FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(8) ==
                                                '') {
                                          return 'Brak odpowiedzi';
                                        } else {
                                          return 'Błędna odpowiedź';
                                        }
                                      }(),
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      'Treść pytania: ${row9QuizQuestionsRecord?.description}',
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  if (row9QuizQuestionsRecord?.questionPhoto !=
                                          null &&
                                      row9QuizQuestionsRecord?.questionPhoto !=
                                          '')
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
                                              child:
                                                  FlutterFlowExpandedImageView(
                                                image: Image.network(
                                                  row9QuizQuestionsRecord
                                                      .questionPhoto,
                                                  fit: BoxFit.contain,
                                                ),
                                                allowRotation: false,
                                                tag: row9QuizQuestionsRecord
                                                    .questionPhoto,
                                                useHeroAnimation: true,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Hero(
                                          tag: row9QuizQuestionsRecord!
                                              .questionPhoto,
                                          transitionOnUserGestures: true,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              row9QuizQuestionsRecord
                                                  .questionPhoto,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if ((FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(8) !=
                                          row9QuizQuestionsRecord
                                              ?.correctAnswerLetter) &&
                                      (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(8) !=
                                              null &&
                                          FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(8) !=
                                              ''))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Twoja odpowiedź: ${FFAppState().selectedOptionsForty.elementAtOrNull(8)}. ${row9QuizQuestionsRecord?.options.elementAtOrNull(() {
                                          if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(8) ==
                                              'A') {
                                            return 0;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(8) ==
                                              'B') {
                                            return 1;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(8) ==
                                              'C') {
                                            return 2;
                                          } else {
                                            return 3;
                                          }
                                        }())}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if (FFAppState()
                                          .selectedOptionsForty
                                          .elementAtOrNull(8) !=
                                      row9QuizQuestionsRecord
                                          ?.correctAnswerLetter)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Poprawna odpowiedź: ${row9QuizQuestionsRecord?.correctAnswerLetter}. ${row9QuizQuestionsRecord?.correctAnswer}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if ((valueOrDefault<bool>(
                                              currentUserDocument
                                                  ?.isUserPremium,
                                              false) ==
                                          true) ||
                                      ((valueOrDefault<bool>(
                                                  currentUserDocument
                                                      ?.isUserPremium,
                                                  false) ==
                                              false) &&
                                          (_model.adWatched == true)))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 12.0),
                                      child: AuthUserStreamWidget(
                                        builder: (context) => Text(
                                          'Wyjaśnienie: ${row9QuizQuestionsRecord?.explenation}',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.manrope(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
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
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                StreamBuilder<List<QuizQuestionsRecord>>(
                  stream: queryQuizQuestionsRecord(
                    queryBuilder: (quizQuestionsRecord) =>
                        quizQuestionsRecord.where(
                      'question_id',
                      isEqualTo:
                          FFAppState().listOfQuestionsID.elementAtOrNull(9),
                    ),
                    singleRecord: true,
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: SpinKitFoldingCube(
                            color: FlutterFlowTheme.of(context).primary,
                            size: 50.0,
                          ),
                        ),
                      );
                    }
                    List<QuizQuestionsRecord> row10QuizQuestionsRecordList =
                        snapshot.data!;
                    // Return an empty Container when the item does not exist.
                    if (snapshot.data!.isEmpty) {
                      return Container();
                    }
                    final row10QuizQuestionsRecord =
                        row10QuizQuestionsRecordList.isNotEmpty
                            ? row10QuizQuestionsRecordList.first
                            : null;

                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 12.0, 16.0, 8.0),
                            child: Container(
                              width: 100.0,
                              decoration: BoxDecoration(
                                color: FFAppState()
                                            .selectedOptionsForty
                                            .elementAtOrNull(9) ==
                                        row10QuizQuestionsRecord
                                            ?.correctAnswerLetter
                                    ? FlutterFlowTheme.of(context)
                                        .correctWithOpacity
                                    : FlutterFlowTheme.of(context)
                                        .wrongAnswerBackground,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15.0),
                                  bottomRight: Radius.circular(15.0),
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                                border: Border.all(
                                  color: FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(9) ==
                                          row10QuizQuestionsRecord
                                              ?.correctAnswerLetter
                                      ? FlutterFlowTheme.of(context).tertiary
                                      : FlutterFlowTheme.of(context)
                                          .wrongAnswerBorder,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      () {
                                        if (row10QuizQuestionsRecord
                                                ?.correctAnswerLetter ==
                                            FFAppState()
                                                .selectedOptionsForty
                                                .elementAtOrNull(9)) {
                                          return 'Poprawna odpowiedź';
                                        } else if (FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(9) ==
                                                null ||
                                            FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(9) ==
                                                '') {
                                          return 'Brak odpowiedzi';
                                        } else {
                                          return 'Błędna odpowiedź';
                                        }
                                      }(),
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      'Treść pytania: ${row10QuizQuestionsRecord?.description}',
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  if (row10QuizQuestionsRecord?.questionPhoto !=
                                          null &&
                                      row10QuizQuestionsRecord?.questionPhoto !=
                                          '')
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
                                              child:
                                                  FlutterFlowExpandedImageView(
                                                image: Image.network(
                                                  row10QuizQuestionsRecord
                                                      .questionPhoto,
                                                  fit: BoxFit.contain,
                                                ),
                                                allowRotation: false,
                                                tag: row10QuizQuestionsRecord
                                                    .questionPhoto,
                                                useHeroAnimation: true,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Hero(
                                          tag: row10QuizQuestionsRecord!
                                              .questionPhoto,
                                          transitionOnUserGestures: true,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              row10QuizQuestionsRecord
                                                  .questionPhoto,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if ((FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(9) !=
                                          row10QuizQuestionsRecord
                                              ?.correctAnswerLetter) &&
                                      (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(9) !=
                                              null &&
                                          FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(9) !=
                                              ''))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Twoja odpowiedź: ${FFAppState().selectedOptionsForty.elementAtOrNull(9)}. ${row10QuizQuestionsRecord?.options.elementAtOrNull(() {
                                          if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(9) ==
                                              'A') {
                                            return 0;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(9) ==
                                              'B') {
                                            return 1;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(9) ==
                                              'C') {
                                            return 2;
                                          } else {
                                            return 3;
                                          }
                                        }())}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if (FFAppState()
                                          .selectedOptionsForty
                                          .elementAtOrNull(9) !=
                                      row10QuizQuestionsRecord
                                          ?.correctAnswerLetter)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Poprawna odpowiedź: ${row10QuizQuestionsRecord?.correctAnswerLetter}. ${row10QuizQuestionsRecord?.correctAnswer}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if ((valueOrDefault<bool>(
                                              currentUserDocument
                                                  ?.isUserPremium,
                                              false) ==
                                          true) ||
                                      ((valueOrDefault<bool>(
                                                  currentUserDocument
                                                      ?.isUserPremium,
                                                  false) ==
                                              false) &&
                                          (_model.adWatched == true)))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 12.0),
                                      child: AuthUserStreamWidget(
                                        builder: (context) => Text(
                                          'Wyjaśnienie: ${row10QuizQuestionsRecord?.explenation}',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.manrope(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
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
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                StreamBuilder<List<QuizQuestionsRecord>>(
                  stream: queryQuizQuestionsRecord(
                    queryBuilder: (quizQuestionsRecord) =>
                        quizQuestionsRecord.where(
                      'question_id',
                      isEqualTo:
                          FFAppState().listOfQuestionsID.elementAtOrNull(10),
                    ),
                    singleRecord: true,
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: SpinKitFoldingCube(
                            color: FlutterFlowTheme.of(context).primary,
                            size: 50.0,
                          ),
                        ),
                      );
                    }
                    List<QuizQuestionsRecord> row11QuizQuestionsRecordList =
                        snapshot.data!;
                    // Return an empty Container when the item does not exist.
                    if (snapshot.data!.isEmpty) {
                      return Container();
                    }
                    final row11QuizQuestionsRecord =
                        row11QuizQuestionsRecordList.isNotEmpty
                            ? row11QuizQuestionsRecordList.first
                            : null;

                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 12.0, 16.0, 8.0),
                            child: Container(
                              width: 100.0,
                              decoration: BoxDecoration(
                                color: FFAppState()
                                            .selectedOptionsForty
                                            .elementAtOrNull(10) ==
                                        row11QuizQuestionsRecord
                                            ?.correctAnswerLetter
                                    ? FlutterFlowTheme.of(context)
                                        .correctWithOpacity
                                    : FlutterFlowTheme.of(context)
                                        .wrongAnswerBackground,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15.0),
                                  bottomRight: Radius.circular(15.0),
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                                border: Border.all(
                                  color: FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(10) ==
                                          row11QuizQuestionsRecord
                                              ?.correctAnswerLetter
                                      ? FlutterFlowTheme.of(context).tertiary
                                      : FlutterFlowTheme.of(context)
                                          .wrongAnswerBorder,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      () {
                                        if (row11QuizQuestionsRecord
                                                ?.correctAnswerLetter ==
                                            FFAppState()
                                                .selectedOptionsForty
                                                .elementAtOrNull(10)) {
                                          return 'Poprawna odpowiedź';
                                        } else if (FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(10) ==
                                                null ||
                                            FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(10) ==
                                                '') {
                                          return 'Brak odpowiedzi';
                                        } else {
                                          return 'Błędna odpowiedź';
                                        }
                                      }(),
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      'Treść pytania: ${row11QuizQuestionsRecord?.description}',
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  if (row11QuizQuestionsRecord?.questionPhoto !=
                                          null &&
                                      row11QuizQuestionsRecord?.questionPhoto !=
                                          '')
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
                                              child:
                                                  FlutterFlowExpandedImageView(
                                                image: Image.network(
                                                  row11QuizQuestionsRecord
                                                      .questionPhoto,
                                                  fit: BoxFit.contain,
                                                ),
                                                allowRotation: false,
                                                tag: row11QuizQuestionsRecord
                                                    .questionPhoto,
                                                useHeroAnimation: true,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Hero(
                                          tag: row11QuizQuestionsRecord!
                                              .questionPhoto,
                                          transitionOnUserGestures: true,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              row11QuizQuestionsRecord
                                                  .questionPhoto,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if ((FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(10) !=
                                          row11QuizQuestionsRecord
                                              ?.correctAnswerLetter) &&
                                      (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(10) !=
                                              null &&
                                          FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(10) !=
                                              ''))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Twoja odpowiedź: ${FFAppState().selectedOptionsForty.elementAtOrNull(10)}. ${row11QuizQuestionsRecord?.options.elementAtOrNull(() {
                                          if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(10) ==
                                              'A') {
                                            return 0;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(10) ==
                                              'B') {
                                            return 1;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(10) ==
                                              'C') {
                                            return 2;
                                          } else {
                                            return 3;
                                          }
                                        }())}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if (FFAppState()
                                          .selectedOptionsForty
                                          .elementAtOrNull(10) !=
                                      row11QuizQuestionsRecord
                                          ?.correctAnswerLetter)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Poprawna odpowiedź: ${row11QuizQuestionsRecord?.correctAnswerLetter}. ${row11QuizQuestionsRecord?.correctAnswer}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if ((valueOrDefault<bool>(
                                              currentUserDocument
                                                  ?.isUserPremium,
                                              false) ==
                                          true) ||
                                      ((valueOrDefault<bool>(
                                                  currentUserDocument
                                                      ?.isUserPremium,
                                                  false) ==
                                              false) &&
                                          (_model.adWatched == true)))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 12.0),
                                      child: AuthUserStreamWidget(
                                        builder: (context) => Text(
                                          'Wyjaśnienie: ${row11QuizQuestionsRecord?.explenation}',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.manrope(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
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
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                StreamBuilder<List<QuizQuestionsRecord>>(
                  stream: queryQuizQuestionsRecord(
                    queryBuilder: (quizQuestionsRecord) =>
                        quizQuestionsRecord.where(
                      'question_id',
                      isEqualTo:
                          FFAppState().listOfQuestionsID.elementAtOrNull(11),
                    ),
                    singleRecord: true,
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: SpinKitFoldingCube(
                            color: FlutterFlowTheme.of(context).primary,
                            size: 50.0,
                          ),
                        ),
                      );
                    }
                    List<QuizQuestionsRecord> row12QuizQuestionsRecordList =
                        snapshot.data!;
                    // Return an empty Container when the item does not exist.
                    if (snapshot.data!.isEmpty) {
                      return Container();
                    }
                    final row12QuizQuestionsRecord =
                        row12QuizQuestionsRecordList.isNotEmpty
                            ? row12QuizQuestionsRecordList.first
                            : null;

                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 12.0, 16.0, 8.0),
                            child: Container(
                              width: 100.0,
                              decoration: BoxDecoration(
                                color: FFAppState()
                                            .selectedOptionsForty
                                            .elementAtOrNull(11) ==
                                        row12QuizQuestionsRecord
                                            ?.correctAnswerLetter
                                    ? FlutterFlowTheme.of(context)
                                        .correctWithOpacity
                                    : FlutterFlowTheme.of(context)
                                        .wrongAnswerBackground,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15.0),
                                  bottomRight: Radius.circular(15.0),
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                                border: Border.all(
                                  color: FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(11) ==
                                          row12QuizQuestionsRecord
                                              ?.correctAnswerLetter
                                      ? FlutterFlowTheme.of(context).tertiary
                                      : FlutterFlowTheme.of(context)
                                          .wrongAnswerBorder,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      () {
                                        if (row12QuizQuestionsRecord
                                                ?.correctAnswerLetter ==
                                            FFAppState()
                                                .selectedOptionsForty
                                                .elementAtOrNull(11)) {
                                          return 'Poprawna odpowiedź';
                                        } else if (FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(11) ==
                                                null ||
                                            FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(11) ==
                                                '') {
                                          return 'Brak odpowiedzi';
                                        } else {
                                          return 'Błędna odpowiedź';
                                        }
                                      }(),
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      'Treść pytania: ${row12QuizQuestionsRecord?.description}',
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  if (row12QuizQuestionsRecord?.questionPhoto !=
                                          null &&
                                      row12QuizQuestionsRecord?.questionPhoto !=
                                          '')
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
                                              child:
                                                  FlutterFlowExpandedImageView(
                                                image: Image.network(
                                                  row12QuizQuestionsRecord
                                                      .questionPhoto,
                                                  fit: BoxFit.contain,
                                                ),
                                                allowRotation: false,
                                                tag: row12QuizQuestionsRecord
                                                    .questionPhoto,
                                                useHeroAnimation: true,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Hero(
                                          tag: row12QuizQuestionsRecord!
                                              .questionPhoto,
                                          transitionOnUserGestures: true,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              row12QuizQuestionsRecord
                                                  .questionPhoto,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if ((FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(11) !=
                                          row12QuizQuestionsRecord
                                              ?.correctAnswerLetter) &&
                                      (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(11) !=
                                              null &&
                                          FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(11) !=
                                              ''))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Twoja odpowiedź: ${FFAppState().selectedOptionsForty.elementAtOrNull(11)}. ${row12QuizQuestionsRecord?.options.elementAtOrNull(() {
                                          if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(11) ==
                                              'A') {
                                            return 0;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(11) ==
                                              'B') {
                                            return 1;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(11) ==
                                              'C') {
                                            return 2;
                                          } else {
                                            return 3;
                                          }
                                        }())}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if (FFAppState()
                                          .selectedOptionsForty
                                          .elementAtOrNull(11) !=
                                      row12QuizQuestionsRecord
                                          ?.correctAnswerLetter)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Poprawna odpowiedź: ${row12QuizQuestionsRecord?.correctAnswerLetter}. ${row12QuizQuestionsRecord?.correctAnswer}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if ((valueOrDefault<bool>(
                                              currentUserDocument
                                                  ?.isUserPremium,
                                              false) ==
                                          true) ||
                                      ((valueOrDefault<bool>(
                                                  currentUserDocument
                                                      ?.isUserPremium,
                                                  false) ==
                                              false) &&
                                          (_model.adWatched == true)))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 12.0),
                                      child: AuthUserStreamWidget(
                                        builder: (context) => Text(
                                          'Wyjaśnienie: ${row12QuizQuestionsRecord?.explenation}',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.manrope(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
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
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                StreamBuilder<List<QuizQuestionsRecord>>(
                  stream: queryQuizQuestionsRecord(
                    queryBuilder: (quizQuestionsRecord) =>
                        quizQuestionsRecord.where(
                      'question_id',
                      isEqualTo:
                          FFAppState().listOfQuestionsID.elementAtOrNull(12),
                    ),
                    singleRecord: true,
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: SpinKitFoldingCube(
                            color: FlutterFlowTheme.of(context).primary,
                            size: 50.0,
                          ),
                        ),
                      );
                    }
                    List<QuizQuestionsRecord> row13QuizQuestionsRecordList =
                        snapshot.data!;
                    // Return an empty Container when the item does not exist.
                    if (snapshot.data!.isEmpty) {
                      return Container();
                    }
                    final row13QuizQuestionsRecord =
                        row13QuizQuestionsRecordList.isNotEmpty
                            ? row13QuizQuestionsRecordList.first
                            : null;

                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 12.0, 16.0, 8.0),
                            child: Container(
                              width: 100.0,
                              decoration: BoxDecoration(
                                color: FFAppState()
                                            .selectedOptionsForty
                                            .elementAtOrNull(12) ==
                                        row13QuizQuestionsRecord
                                            ?.correctAnswerLetter
                                    ? FlutterFlowTheme.of(context)
                                        .correctWithOpacity
                                    : FlutterFlowTheme.of(context)
                                        .wrongAnswerBackground,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15.0),
                                  bottomRight: Radius.circular(15.0),
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                                border: Border.all(
                                  color: FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(12) ==
                                          row13QuizQuestionsRecord
                                              ?.correctAnswerLetter
                                      ? FlutterFlowTheme.of(context).tertiary
                                      : FlutterFlowTheme.of(context)
                                          .wrongAnswerBorder,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      () {
                                        if (row13QuizQuestionsRecord
                                                ?.correctAnswerLetter ==
                                            FFAppState()
                                                .selectedOptionsForty
                                                .elementAtOrNull(12)) {
                                          return 'Poprawna odpowiedź';
                                        } else if (FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(12) ==
                                                null ||
                                            FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(12) ==
                                                '') {
                                          return 'Brak odpowiedzi';
                                        } else {
                                          return 'Błędna odpowiedź';
                                        }
                                      }(),
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      'Treść pytania: ${row13QuizQuestionsRecord?.description}',
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  if (row13QuizQuestionsRecord?.questionPhoto !=
                                          null &&
                                      row13QuizQuestionsRecord?.questionPhoto !=
                                          '')
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
                                              child:
                                                  FlutterFlowExpandedImageView(
                                                image: Image.network(
                                                  row13QuizQuestionsRecord
                                                      .questionPhoto,
                                                  fit: BoxFit.contain,
                                                ),
                                                allowRotation: false,
                                                tag: row13QuizQuestionsRecord
                                                    .questionPhoto,
                                                useHeroAnimation: true,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Hero(
                                          tag: row13QuizQuestionsRecord!
                                              .questionPhoto,
                                          transitionOnUserGestures: true,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              row13QuizQuestionsRecord
                                                  .questionPhoto,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if ((FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(12) !=
                                          row13QuizQuestionsRecord
                                              ?.correctAnswerLetter) &&
                                      (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(12) !=
                                              null &&
                                          FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(12) !=
                                              ''))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Twoja odpowiedź: ${FFAppState().selectedOptionsForty.elementAtOrNull(12)}. ${row13QuizQuestionsRecord?.options.elementAtOrNull(() {
                                          if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(12) ==
                                              'A') {
                                            return 0;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(12) ==
                                              'B') {
                                            return 1;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(12) ==
                                              'C') {
                                            return 2;
                                          } else {
                                            return 3;
                                          }
                                        }())}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if (FFAppState()
                                          .selectedOptionsForty
                                          .elementAtOrNull(12) !=
                                      row13QuizQuestionsRecord
                                          ?.correctAnswerLetter)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Poprawna odpowiedź: ${row13QuizQuestionsRecord?.correctAnswerLetter}. ${row13QuizQuestionsRecord?.correctAnswer}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if ((valueOrDefault<bool>(
                                              currentUserDocument
                                                  ?.isUserPremium,
                                              false) ==
                                          true) ||
                                      ((valueOrDefault<bool>(
                                                  currentUserDocument
                                                      ?.isUserPremium,
                                                  false) ==
                                              false) &&
                                          (_model.adWatched == true)))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 12.0),
                                      child: AuthUserStreamWidget(
                                        builder: (context) => Text(
                                          'Wyjaśnienie: ${row13QuizQuestionsRecord?.explenation}',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.manrope(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
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
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                StreamBuilder<List<QuizQuestionsRecord>>(
                  stream: queryQuizQuestionsRecord(
                    queryBuilder: (quizQuestionsRecord) =>
                        quizQuestionsRecord.where(
                      'question_id',
                      isEqualTo:
                          FFAppState().listOfQuestionsID.elementAtOrNull(13),
                    ),
                    singleRecord: true,
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: SpinKitFoldingCube(
                            color: FlutterFlowTheme.of(context).primary,
                            size: 50.0,
                          ),
                        ),
                      );
                    }
                    List<QuizQuestionsRecord> row14QuizQuestionsRecordList =
                        snapshot.data!;
                    // Return an empty Container when the item does not exist.
                    if (snapshot.data!.isEmpty) {
                      return Container();
                    }
                    final row14QuizQuestionsRecord =
                        row14QuizQuestionsRecordList.isNotEmpty
                            ? row14QuizQuestionsRecordList.first
                            : null;

                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 12.0, 16.0, 8.0),
                            child: Container(
                              width: 100.0,
                              decoration: BoxDecoration(
                                color: FFAppState()
                                            .selectedOptionsForty
                                            .elementAtOrNull(13) ==
                                        row14QuizQuestionsRecord
                                            ?.correctAnswerLetter
                                    ? FlutterFlowTheme.of(context)
                                        .correctWithOpacity
                                    : FlutterFlowTheme.of(context)
                                        .wrongAnswerBackground,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15.0),
                                  bottomRight: Radius.circular(15.0),
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                                border: Border.all(
                                  color: FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(13) ==
                                          row14QuizQuestionsRecord
                                              ?.correctAnswerLetter
                                      ? FlutterFlowTheme.of(context).tertiary
                                      : FlutterFlowTheme.of(context)
                                          .wrongAnswerBorder,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      () {
                                        if (row14QuizQuestionsRecord
                                                ?.correctAnswerLetter ==
                                            FFAppState()
                                                .selectedOptionsForty
                                                .elementAtOrNull(13)) {
                                          return 'Poprawna odpowiedź';
                                        } else if (FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(13) ==
                                                null ||
                                            FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(13) ==
                                                '') {
                                          return 'Brak odpowiedzi';
                                        } else {
                                          return 'Błędna odpowiedź';
                                        }
                                      }(),
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      'Treść pytania: ${row14QuizQuestionsRecord?.description}',
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  if (row14QuizQuestionsRecord?.questionPhoto !=
                                          null &&
                                      row14QuizQuestionsRecord?.questionPhoto !=
                                          '')
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
                                              child:
                                                  FlutterFlowExpandedImageView(
                                                image: Image.network(
                                                  row14QuizQuestionsRecord
                                                      .questionPhoto,
                                                  fit: BoxFit.contain,
                                                ),
                                                allowRotation: false,
                                                tag: row14QuizQuestionsRecord
                                                    .questionPhoto,
                                                useHeroAnimation: true,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Hero(
                                          tag: row14QuizQuestionsRecord!
                                              .questionPhoto,
                                          transitionOnUserGestures: true,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              row14QuizQuestionsRecord
                                                  .questionPhoto,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if ((FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(13) !=
                                          row14QuizQuestionsRecord
                                              ?.correctAnswerLetter) &&
                                      (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(13) !=
                                              null &&
                                          FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(13) !=
                                              ''))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Twoja odpowiedź: ${FFAppState().selectedOptionsForty.elementAtOrNull(13)}. ${row14QuizQuestionsRecord?.options.elementAtOrNull(() {
                                          if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(13) ==
                                              'A') {
                                            return 0;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(13) ==
                                              'B') {
                                            return 1;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(13) ==
                                              'C') {
                                            return 2;
                                          } else {
                                            return 3;
                                          }
                                        }())}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if (FFAppState()
                                          .selectedOptionsForty
                                          .elementAtOrNull(13) !=
                                      row14QuizQuestionsRecord
                                          ?.correctAnswerLetter)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Poprawna odpowiedź: ${row14QuizQuestionsRecord?.correctAnswerLetter}. ${row14QuizQuestionsRecord?.correctAnswer}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if ((valueOrDefault<bool>(
                                              currentUserDocument
                                                  ?.isUserPremium,
                                              false) ==
                                          true) ||
                                      ((valueOrDefault<bool>(
                                                  currentUserDocument
                                                      ?.isUserPremium,
                                                  false) ==
                                              false) &&
                                          (_model.adWatched == true)))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 12.0),
                                      child: AuthUserStreamWidget(
                                        builder: (context) => Text(
                                          'Wyjaśnienie: ${row14QuizQuestionsRecord?.explenation}',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.manrope(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
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
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                StreamBuilder<List<QuizQuestionsRecord>>(
                  stream: queryQuizQuestionsRecord(
                    queryBuilder: (quizQuestionsRecord) =>
                        quizQuestionsRecord.where(
                      'question_id',
                      isEqualTo:
                          FFAppState().listOfQuestionsID.elementAtOrNull(14),
                    ),
                    singleRecord: true,
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: SpinKitFoldingCube(
                            color: FlutterFlowTheme.of(context).primary,
                            size: 50.0,
                          ),
                        ),
                      );
                    }
                    List<QuizQuestionsRecord> row15QuizQuestionsRecordList =
                        snapshot.data!;
                    // Return an empty Container when the item does not exist.
                    if (snapshot.data!.isEmpty) {
                      return Container();
                    }
                    final row15QuizQuestionsRecord =
                        row15QuizQuestionsRecordList.isNotEmpty
                            ? row15QuizQuestionsRecordList.first
                            : null;

                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 12.0, 16.0, 8.0),
                            child: Container(
                              width: 100.0,
                              decoration: BoxDecoration(
                                color: FFAppState()
                                            .selectedOptionsForty
                                            .elementAtOrNull(14) ==
                                        row15QuizQuestionsRecord
                                            ?.correctAnswerLetter
                                    ? FlutterFlowTheme.of(context)
                                        .correctWithOpacity
                                    : FlutterFlowTheme.of(context)
                                        .wrongAnswerBackground,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15.0),
                                  bottomRight: Radius.circular(15.0),
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                                border: Border.all(
                                  color: FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(14) ==
                                          row15QuizQuestionsRecord
                                              ?.correctAnswerLetter
                                      ? FlutterFlowTheme.of(context).tertiary
                                      : FlutterFlowTheme.of(context)
                                          .wrongAnswerBorder,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      () {
                                        if (row15QuizQuestionsRecord
                                                ?.correctAnswerLetter ==
                                            FFAppState()
                                                .selectedOptionsForty
                                                .elementAtOrNull(14)) {
                                          return 'Poprawna odpowiedź';
                                        } else if (FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(14) ==
                                                null ||
                                            FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(14) ==
                                                '') {
                                          return 'Brak odpowiedzi';
                                        } else {
                                          return 'Błędna odpowiedź';
                                        }
                                      }(),
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      'Treść pytania: ${row15QuizQuestionsRecord?.description}',
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  if (row15QuizQuestionsRecord?.questionPhoto !=
                                          null &&
                                      row15QuizQuestionsRecord?.questionPhoto !=
                                          '')
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
                                              child:
                                                  FlutterFlowExpandedImageView(
                                                image: Image.network(
                                                  row15QuizQuestionsRecord
                                                      .questionPhoto,
                                                  fit: BoxFit.contain,
                                                ),
                                                allowRotation: false,
                                                tag: row15QuizQuestionsRecord
                                                    .questionPhoto,
                                                useHeroAnimation: true,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Hero(
                                          tag: row15QuizQuestionsRecord!
                                              .questionPhoto,
                                          transitionOnUserGestures: true,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              row15QuizQuestionsRecord
                                                  .questionPhoto,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if ((FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(14) !=
                                          row15QuizQuestionsRecord
                                              ?.correctAnswerLetter) &&
                                      (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(14) !=
                                              null &&
                                          FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(14) !=
                                              ''))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Twoja odpowiedź: ${FFAppState().selectedOptionsForty.elementAtOrNull(14)}. ${row15QuizQuestionsRecord?.options.elementAtOrNull(() {
                                          if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(14) ==
                                              'A') {
                                            return 0;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(14) ==
                                              'B') {
                                            return 1;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(14) ==
                                              'C') {
                                            return 2;
                                          } else {
                                            return 3;
                                          }
                                        }())}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if (FFAppState()
                                          .selectedOptionsForty
                                          .elementAtOrNull(14) !=
                                      row15QuizQuestionsRecord
                                          ?.correctAnswerLetter)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Poprawna odpowiedź: ${row15QuizQuestionsRecord?.correctAnswerLetter}. ${row15QuizQuestionsRecord?.correctAnswer}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if ((valueOrDefault<bool>(
                                              currentUserDocument
                                                  ?.isUserPremium,
                                              false) ==
                                          true) ||
                                      ((valueOrDefault<bool>(
                                                  currentUserDocument
                                                      ?.isUserPremium,
                                                  false) ==
                                              false) &&
                                          (_model.adWatched == true)))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 12.0),
                                      child: AuthUserStreamWidget(
                                        builder: (context) => Text(
                                          'Wyjaśnienie: ${row15QuizQuestionsRecord?.explenation}',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.manrope(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
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
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                StreamBuilder<List<QuizQuestionsRecord>>(
                  stream: queryQuizQuestionsRecord(
                    queryBuilder: (quizQuestionsRecord) =>
                        quizQuestionsRecord.where(
                      'question_id',
                      isEqualTo:
                          FFAppState().listOfQuestionsID.elementAtOrNull(15),
                    ),
                    singleRecord: true,
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: SpinKitFoldingCube(
                            color: FlutterFlowTheme.of(context).primary,
                            size: 50.0,
                          ),
                        ),
                      );
                    }
                    List<QuizQuestionsRecord> row16QuizQuestionsRecordList =
                        snapshot.data!;
                    // Return an empty Container when the item does not exist.
                    if (snapshot.data!.isEmpty) {
                      return Container();
                    }
                    final row16QuizQuestionsRecord =
                        row16QuizQuestionsRecordList.isNotEmpty
                            ? row16QuizQuestionsRecordList.first
                            : null;

                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 12.0, 16.0, 8.0),
                            child: Container(
                              width: 100.0,
                              decoration: BoxDecoration(
                                color: FFAppState()
                                            .selectedOptionsForty
                                            .elementAtOrNull(15) ==
                                        row16QuizQuestionsRecord
                                            ?.correctAnswerLetter
                                    ? FlutterFlowTheme.of(context)
                                        .correctWithOpacity
                                    : FlutterFlowTheme.of(context)
                                        .wrongAnswerBackground,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15.0),
                                  bottomRight: Radius.circular(15.0),
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                                border: Border.all(
                                  color: FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(15) ==
                                          row16QuizQuestionsRecord
                                              ?.correctAnswerLetter
                                      ? FlutterFlowTheme.of(context).tertiary
                                      : FlutterFlowTheme.of(context)
                                          .wrongAnswerBorder,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      () {
                                        if (row16QuizQuestionsRecord
                                                ?.correctAnswerLetter ==
                                            FFAppState()
                                                .selectedOptionsForty
                                                .elementAtOrNull(15)) {
                                          return 'Poprawna odpowiedź';
                                        } else if (FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(15) ==
                                                null ||
                                            FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(15) ==
                                                '') {
                                          return 'Brak odpowiedzi';
                                        } else {
                                          return 'Błędna odpowiedź';
                                        }
                                      }(),
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      'Treść pytania: ${row16QuizQuestionsRecord?.description}',
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  if (row16QuizQuestionsRecord?.questionPhoto !=
                                          null &&
                                      row16QuizQuestionsRecord?.questionPhoto !=
                                          '')
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
                                              child:
                                                  FlutterFlowExpandedImageView(
                                                image: Image.network(
                                                  row16QuizQuestionsRecord
                                                      .questionPhoto,
                                                  fit: BoxFit.contain,
                                                ),
                                                allowRotation: false,
                                                tag: row16QuizQuestionsRecord
                                                    .questionPhoto,
                                                useHeroAnimation: true,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Hero(
                                          tag: row16QuizQuestionsRecord!
                                              .questionPhoto,
                                          transitionOnUserGestures: true,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              row16QuizQuestionsRecord
                                                  .questionPhoto,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if ((FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(15) !=
                                          row16QuizQuestionsRecord
                                              ?.correctAnswerLetter) &&
                                      (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(15) !=
                                              null &&
                                          FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(15) !=
                                              ''))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Twoja odpowiedź: ${FFAppState().selectedOptionsForty.elementAtOrNull(15)}. ${row16QuizQuestionsRecord?.options.elementAtOrNull(() {
                                          if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(15) ==
                                              'A') {
                                            return 0;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(15) ==
                                              'B') {
                                            return 1;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(15) ==
                                              'C') {
                                            return 2;
                                          } else {
                                            return 3;
                                          }
                                        }())}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if (FFAppState()
                                          .selectedOptionsForty
                                          .elementAtOrNull(15) !=
                                      row16QuizQuestionsRecord
                                          ?.correctAnswerLetter)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Poprawna odpowiedź: ${row16QuizQuestionsRecord?.correctAnswerLetter}. ${row16QuizQuestionsRecord?.correctAnswer}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if ((valueOrDefault<bool>(
                                              currentUserDocument
                                                  ?.isUserPremium,
                                              false) ==
                                          true) ||
                                      ((valueOrDefault<bool>(
                                                  currentUserDocument
                                                      ?.isUserPremium,
                                                  false) ==
                                              false) &&
                                          (_model.adWatched == true)))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 12.0),
                                      child: AuthUserStreamWidget(
                                        builder: (context) => Text(
                                          'Wyjaśnienie: ${row16QuizQuestionsRecord?.explenation}',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.manrope(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
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
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                StreamBuilder<List<QuizQuestionsRecord>>(
                  stream: queryQuizQuestionsRecord(
                    queryBuilder: (quizQuestionsRecord) =>
                        quizQuestionsRecord.where(
                      'question_id',
                      isEqualTo:
                          FFAppState().listOfQuestionsID.elementAtOrNull(16),
                    ),
                    singleRecord: true,
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: SpinKitFoldingCube(
                            color: FlutterFlowTheme.of(context).primary,
                            size: 50.0,
                          ),
                        ),
                      );
                    }
                    List<QuizQuestionsRecord> row17QuizQuestionsRecordList =
                        snapshot.data!;
                    // Return an empty Container when the item does not exist.
                    if (snapshot.data!.isEmpty) {
                      return Container();
                    }
                    final row17QuizQuestionsRecord =
                        row17QuizQuestionsRecordList.isNotEmpty
                            ? row17QuizQuestionsRecordList.first
                            : null;

                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 12.0, 16.0, 8.0),
                            child: Container(
                              width: 100.0,
                              decoration: BoxDecoration(
                                color: FFAppState()
                                            .selectedOptionsForty
                                            .elementAtOrNull(16) ==
                                        row17QuizQuestionsRecord
                                            ?.correctAnswerLetter
                                    ? FlutterFlowTheme.of(context)
                                        .correctWithOpacity
                                    : FlutterFlowTheme.of(context)
                                        .wrongAnswerBackground,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15.0),
                                  bottomRight: Radius.circular(15.0),
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                                border: Border.all(
                                  color: FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(16) ==
                                          row17QuizQuestionsRecord
                                              ?.correctAnswerLetter
                                      ? FlutterFlowTheme.of(context).tertiary
                                      : FlutterFlowTheme.of(context)
                                          .wrongAnswerBorder,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      () {
                                        if (row17QuizQuestionsRecord
                                                ?.correctAnswerLetter ==
                                            FFAppState()
                                                .selectedOptionsForty
                                                .elementAtOrNull(16)) {
                                          return 'Poprawna odpowiedź';
                                        } else if (FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(16) ==
                                                null ||
                                            FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(16) ==
                                                '') {
                                          return 'Brak odpowiedzi';
                                        } else {
                                          return 'Błędna odpowiedź';
                                        }
                                      }(),
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      'Treść pytania: ${row17QuizQuestionsRecord?.description}',
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  if (row17QuizQuestionsRecord?.questionPhoto !=
                                          null &&
                                      row17QuizQuestionsRecord?.questionPhoto !=
                                          '')
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
                                              child:
                                                  FlutterFlowExpandedImageView(
                                                image: Image.network(
                                                  row17QuizQuestionsRecord
                                                      .questionPhoto,
                                                  fit: BoxFit.contain,
                                                ),
                                                allowRotation: false,
                                                tag: row17QuizQuestionsRecord
                                                    .questionPhoto,
                                                useHeroAnimation: true,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Hero(
                                          tag: row17QuizQuestionsRecord!
                                              .questionPhoto,
                                          transitionOnUserGestures: true,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              row17QuizQuestionsRecord
                                                  .questionPhoto,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if ((FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(16) !=
                                          row17QuizQuestionsRecord
                                              ?.correctAnswerLetter) &&
                                      (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(16) !=
                                              null &&
                                          FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(16) !=
                                              ''))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Twoja odpowiedź: ${FFAppState().selectedOptionsForty.elementAtOrNull(16)}. ${row17QuizQuestionsRecord?.options.elementAtOrNull(() {
                                          if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(16) ==
                                              'A') {
                                            return 0;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(16) ==
                                              'B') {
                                            return 1;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(16) ==
                                              'C') {
                                            return 2;
                                          } else {
                                            return 3;
                                          }
                                        }())}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if (FFAppState()
                                          .selectedOptionsForty
                                          .elementAtOrNull(16) !=
                                      row17QuizQuestionsRecord
                                          ?.correctAnswerLetter)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Poprawna odpowiedź: ${row17QuizQuestionsRecord?.correctAnswerLetter}. ${row17QuizQuestionsRecord?.correctAnswer}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if ((valueOrDefault<bool>(
                                              currentUserDocument
                                                  ?.isUserPremium,
                                              false) ==
                                          true) ||
                                      ((valueOrDefault<bool>(
                                                  currentUserDocument
                                                      ?.isUserPremium,
                                                  false) ==
                                              false) &&
                                          (_model.adWatched == true)))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 12.0),
                                      child: AuthUserStreamWidget(
                                        builder: (context) => Text(
                                          'Wyjaśnienie: ${row17QuizQuestionsRecord?.explenation}',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.manrope(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
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
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                StreamBuilder<List<QuizQuestionsRecord>>(
                  stream: queryQuizQuestionsRecord(
                    queryBuilder: (quizQuestionsRecord) =>
                        quizQuestionsRecord.where(
                      'question_id',
                      isEqualTo:
                          FFAppState().listOfQuestionsID.elementAtOrNull(17),
                    ),
                    singleRecord: true,
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: SpinKitFoldingCube(
                            color: FlutterFlowTheme.of(context).primary,
                            size: 50.0,
                          ),
                        ),
                      );
                    }
                    List<QuizQuestionsRecord> row18QuizQuestionsRecordList =
                        snapshot.data!;
                    // Return an empty Container when the item does not exist.
                    if (snapshot.data!.isEmpty) {
                      return Container();
                    }
                    final row18QuizQuestionsRecord =
                        row18QuizQuestionsRecordList.isNotEmpty
                            ? row18QuizQuestionsRecordList.first
                            : null;

                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 12.0, 16.0, 8.0),
                            child: Container(
                              width: 100.0,
                              decoration: BoxDecoration(
                                color: FFAppState()
                                            .selectedOptionsForty
                                            .elementAtOrNull(17) ==
                                        row18QuizQuestionsRecord
                                            ?.correctAnswerLetter
                                    ? FlutterFlowTheme.of(context)
                                        .correctWithOpacity
                                    : FlutterFlowTheme.of(context)
                                        .wrongAnswerBackground,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15.0),
                                  bottomRight: Radius.circular(15.0),
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                                border: Border.all(
                                  color: FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(17) ==
                                          row18QuizQuestionsRecord
                                              ?.correctAnswerLetter
                                      ? FlutterFlowTheme.of(context).tertiary
                                      : FlutterFlowTheme.of(context)
                                          .wrongAnswerBorder,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      () {
                                        if (row18QuizQuestionsRecord
                                                ?.correctAnswerLetter ==
                                            FFAppState()
                                                .selectedOptionsForty
                                                .elementAtOrNull(17)) {
                                          return 'Poprawna odpowiedź';
                                        } else if (FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(17) ==
                                                null ||
                                            FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(17) ==
                                                '') {
                                          return 'Brak odpowiedzi';
                                        } else {
                                          return 'Błędna odpowiedź';
                                        }
                                      }(),
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      'Treść pytania: ${row18QuizQuestionsRecord?.description}',
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  if (row18QuizQuestionsRecord?.questionPhoto !=
                                          null &&
                                      row18QuizQuestionsRecord?.questionPhoto !=
                                          '')
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
                                              child:
                                                  FlutterFlowExpandedImageView(
                                                image: Image.network(
                                                  row18QuizQuestionsRecord
                                                      .questionPhoto,
                                                  fit: BoxFit.contain,
                                                ),
                                                allowRotation: false,
                                                tag: row18QuizQuestionsRecord
                                                    .questionPhoto,
                                                useHeroAnimation: true,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Hero(
                                          tag: row18QuizQuestionsRecord!
                                              .questionPhoto,
                                          transitionOnUserGestures: true,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              row18QuizQuestionsRecord
                                                  .questionPhoto,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if ((FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(17) !=
                                          row18QuizQuestionsRecord
                                              ?.correctAnswerLetter) &&
                                      (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(17) !=
                                              null &&
                                          FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(17) !=
                                              ''))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Twoja odpowiedź: ${FFAppState().selectedOptionsForty.elementAtOrNull(17)}. ${row18QuizQuestionsRecord?.options.elementAtOrNull(() {
                                          if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(17) ==
                                              'A') {
                                            return 0;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(17) ==
                                              'B') {
                                            return 1;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(17) ==
                                              'C') {
                                            return 2;
                                          } else {
                                            return 3;
                                          }
                                        }())}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if (FFAppState()
                                          .selectedOptionsForty
                                          .elementAtOrNull(17) !=
                                      row18QuizQuestionsRecord
                                          ?.correctAnswerLetter)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Poprawna odpowiedź: ${row18QuizQuestionsRecord?.correctAnswerLetter}. ${row18QuizQuestionsRecord?.correctAnswer}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if ((valueOrDefault<bool>(
                                              currentUserDocument
                                                  ?.isUserPremium,
                                              false) ==
                                          true) ||
                                      ((valueOrDefault<bool>(
                                                  currentUserDocument
                                                      ?.isUserPremium,
                                                  false) ==
                                              false) &&
                                          (_model.adWatched == true)))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 12.0),
                                      child: AuthUserStreamWidget(
                                        builder: (context) => Text(
                                          'Wyjaśnienie: ${row18QuizQuestionsRecord?.explenation}',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.manrope(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
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
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                StreamBuilder<List<QuizQuestionsRecord>>(
                  stream: queryQuizQuestionsRecord(
                    queryBuilder: (quizQuestionsRecord) =>
                        quizQuestionsRecord.where(
                      'question_id',
                      isEqualTo:
                          FFAppState().listOfQuestionsID.elementAtOrNull(18),
                    ),
                    singleRecord: true,
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: SpinKitFoldingCube(
                            color: FlutterFlowTheme.of(context).primary,
                            size: 50.0,
                          ),
                        ),
                      );
                    }
                    List<QuizQuestionsRecord> row19QuizQuestionsRecordList =
                        snapshot.data!;
                    // Return an empty Container when the item does not exist.
                    if (snapshot.data!.isEmpty) {
                      return Container();
                    }
                    final row19QuizQuestionsRecord =
                        row19QuizQuestionsRecordList.isNotEmpty
                            ? row19QuizQuestionsRecordList.first
                            : null;

                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 12.0, 16.0, 8.0),
                            child: Container(
                              width: 100.0,
                              decoration: BoxDecoration(
                                color: FFAppState()
                                            .selectedOptionsForty
                                            .elementAtOrNull(18) ==
                                        row19QuizQuestionsRecord
                                            ?.correctAnswerLetter
                                    ? FlutterFlowTheme.of(context)
                                        .correctWithOpacity
                                    : FlutterFlowTheme.of(context)
                                        .wrongAnswerBackground,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15.0),
                                  bottomRight: Radius.circular(15.0),
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                                border: Border.all(
                                  color: FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(18) ==
                                          row19QuizQuestionsRecord
                                              ?.correctAnswerLetter
                                      ? FlutterFlowTheme.of(context).tertiary
                                      : FlutterFlowTheme.of(context)
                                          .wrongAnswerBorder,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      () {
                                        if (row19QuizQuestionsRecord
                                                ?.correctAnswerLetter ==
                                            FFAppState()
                                                .selectedOptionsForty
                                                .elementAtOrNull(18)) {
                                          return 'Poprawna odpowiedź';
                                        } else if (FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(18) ==
                                                null ||
                                            FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(18) ==
                                                '') {
                                          return 'Brak odpowiedzi';
                                        } else {
                                          return 'Błędna odpowiedź';
                                        }
                                      }(),
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      'Treść pytania: ${row19QuizQuestionsRecord?.description}',
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  if (row19QuizQuestionsRecord?.questionPhoto !=
                                          null &&
                                      row19QuizQuestionsRecord?.questionPhoto !=
                                          '')
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
                                              child:
                                                  FlutterFlowExpandedImageView(
                                                image: Image.network(
                                                  row19QuizQuestionsRecord
                                                      .questionPhoto,
                                                  fit: BoxFit.contain,
                                                ),
                                                allowRotation: false,
                                                tag: row19QuizQuestionsRecord
                                                    .questionPhoto,
                                                useHeroAnimation: true,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Hero(
                                          tag: row19QuizQuestionsRecord!
                                              .questionPhoto,
                                          transitionOnUserGestures: true,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              row19QuizQuestionsRecord
                                                  .questionPhoto,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if ((FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(18) !=
                                          row19QuizQuestionsRecord
                                              ?.correctAnswerLetter) &&
                                      (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(18) !=
                                              null &&
                                          FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(18) !=
                                              ''))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Twoja odpowiedź: ${FFAppState().selectedOptionsForty.elementAtOrNull(18)}. ${row19QuizQuestionsRecord?.options.elementAtOrNull(() {
                                          if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(18) ==
                                              'A') {
                                            return 0;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(18) ==
                                              'B') {
                                            return 1;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(18) ==
                                              'C') {
                                            return 2;
                                          } else {
                                            return 3;
                                          }
                                        }())}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if (FFAppState()
                                          .selectedOptionsForty
                                          .elementAtOrNull(18) !=
                                      row19QuizQuestionsRecord
                                          ?.correctAnswerLetter)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Poprawna odpowiedź: ${row19QuizQuestionsRecord?.correctAnswerLetter}. ${row19QuizQuestionsRecord?.correctAnswer}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if ((valueOrDefault<bool>(
                                              currentUserDocument
                                                  ?.isUserPremium,
                                              false) ==
                                          true) ||
                                      ((valueOrDefault<bool>(
                                                  currentUserDocument
                                                      ?.isUserPremium,
                                                  false) ==
                                              false) &&
                                          (_model.adWatched == true)))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 12.0),
                                      child: AuthUserStreamWidget(
                                        builder: (context) => Text(
                                          'Wyjaśnienie: ${row19QuizQuestionsRecord?.explenation}',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.manrope(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
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
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                StreamBuilder<List<QuizQuestionsRecord>>(
                  stream: queryQuizQuestionsRecord(
                    queryBuilder: (quizQuestionsRecord) =>
                        quizQuestionsRecord.where(
                      'question_id',
                      isEqualTo:
                          FFAppState().listOfQuestionsID.elementAtOrNull(19),
                    ),
                    singleRecord: true,
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: SpinKitFoldingCube(
                            color: FlutterFlowTheme.of(context).primary,
                            size: 50.0,
                          ),
                        ),
                      );
                    }
                    List<QuizQuestionsRecord> row20QuizQuestionsRecordList =
                        snapshot.data!;
                    // Return an empty Container when the item does not exist.
                    if (snapshot.data!.isEmpty) {
                      return Container();
                    }
                    final row20QuizQuestionsRecord =
                        row20QuizQuestionsRecordList.isNotEmpty
                            ? row20QuizQuestionsRecordList.first
                            : null;

                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 12.0, 16.0, 8.0),
                            child: Container(
                              width: 100.0,
                              decoration: BoxDecoration(
                                color: FFAppState()
                                            .selectedOptionsForty
                                            .elementAtOrNull(19) ==
                                        row20QuizQuestionsRecord
                                            ?.correctAnswerLetter
                                    ? FlutterFlowTheme.of(context)
                                        .correctWithOpacity
                                    : FlutterFlowTheme.of(context)
                                        .wrongAnswerBackground,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15.0),
                                  bottomRight: Radius.circular(15.0),
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                                border: Border.all(
                                  color: FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(19) ==
                                          row20QuizQuestionsRecord
                                              ?.correctAnswerLetter
                                      ? FlutterFlowTheme.of(context).tertiary
                                      : FlutterFlowTheme.of(context)
                                          .wrongAnswerBorder,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      () {
                                        if (row20QuizQuestionsRecord
                                                ?.correctAnswerLetter ==
                                            FFAppState()
                                                .selectedOptionsForty
                                                .elementAtOrNull(19)) {
                                          return 'Poprawna odpowiedź';
                                        } else if (FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(19) ==
                                                null ||
                                            FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(19) ==
                                                '') {
                                          return 'Brak odpowiedzi';
                                        } else {
                                          return 'Błędna odpowiedź';
                                        }
                                      }(),
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      'Treść pytania: ${row20QuizQuestionsRecord?.description}',
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  if (row20QuizQuestionsRecord?.questionPhoto !=
                                          null &&
                                      row20QuizQuestionsRecord?.questionPhoto !=
                                          '')
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
                                              child:
                                                  FlutterFlowExpandedImageView(
                                                image: Image.network(
                                                  row20QuizQuestionsRecord
                                                      .questionPhoto,
                                                  fit: BoxFit.contain,
                                                ),
                                                allowRotation: false,
                                                tag: row20QuizQuestionsRecord
                                                    .questionPhoto,
                                                useHeroAnimation: true,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Hero(
                                          tag: row20QuizQuestionsRecord!
                                              .questionPhoto,
                                          transitionOnUserGestures: true,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              row20QuizQuestionsRecord
                                                  .questionPhoto,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if ((FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(19) !=
                                          row20QuizQuestionsRecord
                                              ?.correctAnswerLetter) &&
                                      (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(19) !=
                                              null &&
                                          FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(19) !=
                                              ''))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Twoja odpowiedź: ${FFAppState().selectedOptionsForty.elementAtOrNull(19)}. ${row20QuizQuestionsRecord?.options.elementAtOrNull(() {
                                          if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(19) ==
                                              'A') {
                                            return 0;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(19) ==
                                              'B') {
                                            return 1;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(19) ==
                                              'C') {
                                            return 2;
                                          } else {
                                            return 3;
                                          }
                                        }())}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if (FFAppState()
                                          .selectedOptionsForty
                                          .elementAtOrNull(19) !=
                                      row20QuizQuestionsRecord
                                          ?.correctAnswerLetter)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Poprawna odpowiedź: ${row20QuizQuestionsRecord?.correctAnswerLetter}. ${row20QuizQuestionsRecord?.correctAnswer}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if ((valueOrDefault<bool>(
                                              currentUserDocument
                                                  ?.isUserPremium,
                                              false) ==
                                          true) ||
                                      ((valueOrDefault<bool>(
                                                  currentUserDocument
                                                      ?.isUserPremium,
                                                  false) ==
                                              false) &&
                                          (_model.adWatched == true)))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 12.0),
                                      child: AuthUserStreamWidget(
                                        builder: (context) => Text(
                                          'Wyjaśnienie: ${row20QuizQuestionsRecord?.explenation}',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.manrope(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
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
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                StreamBuilder<List<QuizQuestionsRecord>>(
                  stream: queryQuizQuestionsRecord(
                    queryBuilder: (quizQuestionsRecord) =>
                        quizQuestionsRecord.where(
                      'question_id',
                      isEqualTo:
                          FFAppState().listOfQuestionsID.elementAtOrNull(20),
                    ),
                    singleRecord: true,
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: SpinKitFoldingCube(
                            color: FlutterFlowTheme.of(context).primary,
                            size: 50.0,
                          ),
                        ),
                      );
                    }
                    List<QuizQuestionsRecord> row21QuizQuestionsRecordList =
                        snapshot.data!;
                    // Return an empty Container when the item does not exist.
                    if (snapshot.data!.isEmpty) {
                      return Container();
                    }
                    final row21QuizQuestionsRecord =
                        row21QuizQuestionsRecordList.isNotEmpty
                            ? row21QuizQuestionsRecordList.first
                            : null;

                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 12.0, 16.0, 8.0),
                            child: Container(
                              width: 100.0,
                              decoration: BoxDecoration(
                                color: FFAppState()
                                            .selectedOptionsForty
                                            .elementAtOrNull(20) ==
                                        row21QuizQuestionsRecord
                                            ?.correctAnswerLetter
                                    ? FlutterFlowTheme.of(context)
                                        .correctWithOpacity
                                    : FlutterFlowTheme.of(context)
                                        .wrongAnswerBackground,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15.0),
                                  bottomRight: Radius.circular(15.0),
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                                border: Border.all(
                                  color: FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(20) ==
                                          row21QuizQuestionsRecord
                                              ?.correctAnswerLetter
                                      ? FlutterFlowTheme.of(context).tertiary
                                      : FlutterFlowTheme.of(context)
                                          .wrongAnswerBorder,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      () {
                                        if (row21QuizQuestionsRecord
                                                ?.correctAnswerLetter ==
                                            FFAppState()
                                                .selectedOptionsForty
                                                .elementAtOrNull(20)) {
                                          return 'Poprawna odpowiedź';
                                        } else if (FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(20) ==
                                                null ||
                                            FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(20) ==
                                                '') {
                                          return 'Brak odpowiedzi';
                                        } else {
                                          return 'Błędna odpowiedź';
                                        }
                                      }(),
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      'Treść pytania: ${row21QuizQuestionsRecord?.description}',
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  if (row21QuizQuestionsRecord?.questionPhoto !=
                                          null &&
                                      row21QuizQuestionsRecord?.questionPhoto !=
                                          '')
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
                                              child:
                                                  FlutterFlowExpandedImageView(
                                                image: Image.network(
                                                  row21QuizQuestionsRecord
                                                      .questionPhoto,
                                                  fit: BoxFit.contain,
                                                ),
                                                allowRotation: false,
                                                tag: row21QuizQuestionsRecord
                                                    .questionPhoto,
                                                useHeroAnimation: true,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Hero(
                                          tag: row21QuizQuestionsRecord!
                                              .questionPhoto,
                                          transitionOnUserGestures: true,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              row21QuizQuestionsRecord
                                                  .questionPhoto,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if ((FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(20) !=
                                          row21QuizQuestionsRecord
                                              ?.correctAnswerLetter) &&
                                      (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(20) !=
                                              null &&
                                          FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(20) !=
                                              ''))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Twoja odpowiedź: ${FFAppState().selectedOptionsForty.elementAtOrNull(20)}. ${row21QuizQuestionsRecord?.options.elementAtOrNull(() {
                                          if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(20) ==
                                              'A') {
                                            return 0;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(20) ==
                                              'B') {
                                            return 1;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(20) ==
                                              'C') {
                                            return 2;
                                          } else {
                                            return 3;
                                          }
                                        }())}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if (FFAppState()
                                          .selectedOptionsForty
                                          .elementAtOrNull(20) !=
                                      row21QuizQuestionsRecord
                                          ?.correctAnswerLetter)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Poprawna odpowiedź: ${row21QuizQuestionsRecord?.correctAnswerLetter}. ${row21QuizQuestionsRecord?.correctAnswer}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if ((valueOrDefault<bool>(
                                              currentUserDocument
                                                  ?.isUserPremium,
                                              false) ==
                                          true) ||
                                      ((valueOrDefault<bool>(
                                                  currentUserDocument
                                                      ?.isUserPremium,
                                                  false) ==
                                              false) &&
                                          (_model.adWatched == true)))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 12.0),
                                      child: AuthUserStreamWidget(
                                        builder: (context) => Text(
                                          'Wyjaśnienie: ${row21QuizQuestionsRecord?.explenation}',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.manrope(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
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
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                StreamBuilder<List<QuizQuestionsRecord>>(
                  stream: queryQuizQuestionsRecord(
                    queryBuilder: (quizQuestionsRecord) =>
                        quizQuestionsRecord.where(
                      'question_id',
                      isEqualTo:
                          FFAppState().listOfQuestionsID.elementAtOrNull(21),
                    ),
                    singleRecord: true,
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: SpinKitFoldingCube(
                            color: FlutterFlowTheme.of(context).primary,
                            size: 50.0,
                          ),
                        ),
                      );
                    }
                    List<QuizQuestionsRecord> row22QuizQuestionsRecordList =
                        snapshot.data!;
                    // Return an empty Container when the item does not exist.
                    if (snapshot.data!.isEmpty) {
                      return Container();
                    }
                    final row22QuizQuestionsRecord =
                        row22QuizQuestionsRecordList.isNotEmpty
                            ? row22QuizQuestionsRecordList.first
                            : null;

                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 12.0, 16.0, 8.0),
                            child: Container(
                              width: 100.0,
                              decoration: BoxDecoration(
                                color: FFAppState()
                                            .selectedOptionsForty
                                            .elementAtOrNull(21) ==
                                        row22QuizQuestionsRecord
                                            ?.correctAnswerLetter
                                    ? FlutterFlowTheme.of(context)
                                        .correctWithOpacity
                                    : FlutterFlowTheme.of(context)
                                        .wrongAnswerBackground,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15.0),
                                  bottomRight: Radius.circular(15.0),
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                                border: Border.all(
                                  color: FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(21) ==
                                          row22QuizQuestionsRecord
                                              ?.correctAnswerLetter
                                      ? FlutterFlowTheme.of(context).tertiary
                                      : FlutterFlowTheme.of(context)
                                          .wrongAnswerBorder,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      () {
                                        if (row22QuizQuestionsRecord
                                                ?.correctAnswerLetter ==
                                            FFAppState()
                                                .selectedOptionsForty
                                                .elementAtOrNull(21)) {
                                          return 'Poprawna odpowiedź';
                                        } else if (FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(21) ==
                                                null ||
                                            FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(21) ==
                                                '') {
                                          return 'Brak odpowiedzi';
                                        } else {
                                          return 'Błędna odpowiedź';
                                        }
                                      }(),
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      'Treść pytania: ${row22QuizQuestionsRecord?.description}',
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  if (row22QuizQuestionsRecord?.questionPhoto !=
                                          null &&
                                      row22QuizQuestionsRecord?.questionPhoto !=
                                          '')
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
                                              child:
                                                  FlutterFlowExpandedImageView(
                                                image: Image.network(
                                                  row22QuizQuestionsRecord
                                                      .questionPhoto,
                                                  fit: BoxFit.contain,
                                                ),
                                                allowRotation: false,
                                                tag: row22QuizQuestionsRecord
                                                    .questionPhoto,
                                                useHeroAnimation: true,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Hero(
                                          tag: row22QuizQuestionsRecord!
                                              .questionPhoto,
                                          transitionOnUserGestures: true,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              row22QuizQuestionsRecord
                                                  .questionPhoto,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if ((FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(21) !=
                                          row22QuizQuestionsRecord
                                              ?.correctAnswerLetter) &&
                                      (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(21) !=
                                              null &&
                                          FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(21) !=
                                              ''))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Twoja odpowiedź: ${FFAppState().selectedOptionsForty.elementAtOrNull(21)}. ${row22QuizQuestionsRecord?.options.elementAtOrNull(() {
                                          if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(21) ==
                                              'A') {
                                            return 0;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(21) ==
                                              'B') {
                                            return 1;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(21) ==
                                              'C') {
                                            return 2;
                                          } else {
                                            return 3;
                                          }
                                        }())}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if (FFAppState()
                                          .selectedOptionsForty
                                          .elementAtOrNull(21) !=
                                      row22QuizQuestionsRecord
                                          ?.correctAnswerLetter)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Poprawna odpowiedź: ${row22QuizQuestionsRecord?.correctAnswerLetter}. ${row22QuizQuestionsRecord?.correctAnswer}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if ((valueOrDefault<bool>(
                                              currentUserDocument
                                                  ?.isUserPremium,
                                              false) ==
                                          true) ||
                                      ((valueOrDefault<bool>(
                                                  currentUserDocument
                                                      ?.isUserPremium,
                                                  false) ==
                                              false) &&
                                          (_model.adWatched == true)))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 12.0),
                                      child: AuthUserStreamWidget(
                                        builder: (context) => Text(
                                          'Wyjaśnienie: ${row22QuizQuestionsRecord?.explenation}',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.manrope(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
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
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                StreamBuilder<List<QuizQuestionsRecord>>(
                  stream: queryQuizQuestionsRecord(
                    queryBuilder: (quizQuestionsRecord) =>
                        quizQuestionsRecord.where(
                      'question_id',
                      isEqualTo:
                          FFAppState().listOfQuestionsID.elementAtOrNull(22),
                    ),
                    singleRecord: true,
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: SpinKitFoldingCube(
                            color: FlutterFlowTheme.of(context).primary,
                            size: 50.0,
                          ),
                        ),
                      );
                    }
                    List<QuizQuestionsRecord> row23QuizQuestionsRecordList =
                        snapshot.data!;
                    // Return an empty Container when the item does not exist.
                    if (snapshot.data!.isEmpty) {
                      return Container();
                    }
                    final row23QuizQuestionsRecord =
                        row23QuizQuestionsRecordList.isNotEmpty
                            ? row23QuizQuestionsRecordList.first
                            : null;

                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 12.0, 16.0, 8.0),
                            child: Container(
                              width: 100.0,
                              decoration: BoxDecoration(
                                color: FFAppState()
                                            .selectedOptionsForty
                                            .elementAtOrNull(22) ==
                                        row23QuizQuestionsRecord
                                            ?.correctAnswerLetter
                                    ? FlutterFlowTheme.of(context)
                                        .correctWithOpacity
                                    : FlutterFlowTheme.of(context)
                                        .wrongAnswerBackground,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15.0),
                                  bottomRight: Radius.circular(15.0),
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                                border: Border.all(
                                  color: FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(22) ==
                                          row23QuizQuestionsRecord
                                              ?.correctAnswerLetter
                                      ? FlutterFlowTheme.of(context).tertiary
                                      : FlutterFlowTheme.of(context)
                                          .wrongAnswerBorder,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      () {
                                        if (row23QuizQuestionsRecord
                                                ?.correctAnswerLetter ==
                                            FFAppState()
                                                .selectedOptionsForty
                                                .elementAtOrNull(22)) {
                                          return 'Poprawna odpowiedź';
                                        } else if (FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(22) ==
                                                null ||
                                            FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(22) ==
                                                '') {
                                          return 'Brak odpowiedzi';
                                        } else {
                                          return 'Błędna odpowiedź';
                                        }
                                      }(),
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      'Treść pytania: ${row23QuizQuestionsRecord?.description}',
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  if (row23QuizQuestionsRecord?.questionPhoto !=
                                          null &&
                                      row23QuizQuestionsRecord?.questionPhoto !=
                                          '')
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
                                              child:
                                                  FlutterFlowExpandedImageView(
                                                image: Image.network(
                                                  row23QuizQuestionsRecord
                                                      .questionPhoto,
                                                  fit: BoxFit.contain,
                                                ),
                                                allowRotation: false,
                                                tag: row23QuizQuestionsRecord
                                                    .questionPhoto,
                                                useHeroAnimation: true,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Hero(
                                          tag: row23QuizQuestionsRecord!
                                              .questionPhoto,
                                          transitionOnUserGestures: true,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              row23QuizQuestionsRecord
                                                  .questionPhoto,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if ((FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(22) !=
                                          row23QuizQuestionsRecord
                                              ?.correctAnswerLetter) &&
                                      (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(22) !=
                                              null &&
                                          FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(22) !=
                                              ''))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Twoja odpowiedź: ${FFAppState().selectedOptionsForty.elementAtOrNull(22)}. ${row23QuizQuestionsRecord?.options.elementAtOrNull(() {
                                          if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(22) ==
                                              'A') {
                                            return 0;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(22) ==
                                              'B') {
                                            return 1;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(22) ==
                                              'C') {
                                            return 2;
                                          } else {
                                            return 3;
                                          }
                                        }())}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if (FFAppState()
                                          .selectedOptionsForty
                                          .elementAtOrNull(22) !=
                                      row23QuizQuestionsRecord
                                          ?.correctAnswerLetter)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Poprawna odpowiedź: ${row23QuizQuestionsRecord?.correctAnswerLetter}. ${row23QuizQuestionsRecord?.correctAnswer}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if ((valueOrDefault<bool>(
                                              currentUserDocument
                                                  ?.isUserPremium,
                                              false) ==
                                          true) ||
                                      ((valueOrDefault<bool>(
                                                  currentUserDocument
                                                      ?.isUserPremium,
                                                  false) ==
                                              false) &&
                                          (_model.adWatched == true)))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 12.0),
                                      child: AuthUserStreamWidget(
                                        builder: (context) => Text(
                                          'Wyjaśnienie: ${row23QuizQuestionsRecord?.explenation}',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.manrope(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
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
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                StreamBuilder<List<QuizQuestionsRecord>>(
                  stream: queryQuizQuestionsRecord(
                    queryBuilder: (quizQuestionsRecord) =>
                        quizQuestionsRecord.where(
                      'question_id',
                      isEqualTo:
                          FFAppState().listOfQuestionsID.elementAtOrNull(23),
                    ),
                    singleRecord: true,
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: SpinKitFoldingCube(
                            color: FlutterFlowTheme.of(context).primary,
                            size: 50.0,
                          ),
                        ),
                      );
                    }
                    List<QuizQuestionsRecord> row24QuizQuestionsRecordList =
                        snapshot.data!;
                    // Return an empty Container when the item does not exist.
                    if (snapshot.data!.isEmpty) {
                      return Container();
                    }
                    final row24QuizQuestionsRecord =
                        row24QuizQuestionsRecordList.isNotEmpty
                            ? row24QuizQuestionsRecordList.first
                            : null;

                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 12.0, 16.0, 8.0),
                            child: Container(
                              width: 100.0,
                              decoration: BoxDecoration(
                                color: FFAppState()
                                            .selectedOptionsForty
                                            .elementAtOrNull(23) ==
                                        row24QuizQuestionsRecord
                                            ?.correctAnswerLetter
                                    ? FlutterFlowTheme.of(context)
                                        .correctWithOpacity
                                    : FlutterFlowTheme.of(context)
                                        .wrongAnswerBackground,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15.0),
                                  bottomRight: Radius.circular(15.0),
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                                border: Border.all(
                                  color: FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(23) ==
                                          row24QuizQuestionsRecord
                                              ?.correctAnswerLetter
                                      ? FlutterFlowTheme.of(context).tertiary
                                      : FlutterFlowTheme.of(context)
                                          .wrongAnswerBorder,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      () {
                                        if (row24QuizQuestionsRecord
                                                ?.correctAnswerLetter ==
                                            FFAppState()
                                                .selectedOptionsForty
                                                .elementAtOrNull(23)) {
                                          return 'Poprawna odpowiedź';
                                        } else if (FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(23) ==
                                                null ||
                                            FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(23) ==
                                                '') {
                                          return 'Brak odpowiedzi';
                                        } else {
                                          return 'Błędna odpowiedź';
                                        }
                                      }(),
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      'Treść pytania: ${row24QuizQuestionsRecord?.description}',
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  if (row24QuizQuestionsRecord?.questionPhoto !=
                                          null &&
                                      row24QuizQuestionsRecord?.questionPhoto !=
                                          '')
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
                                              child:
                                                  FlutterFlowExpandedImageView(
                                                image: Image.network(
                                                  row24QuizQuestionsRecord
                                                      .questionPhoto,
                                                  fit: BoxFit.contain,
                                                ),
                                                allowRotation: false,
                                                tag: row24QuizQuestionsRecord
                                                    .questionPhoto,
                                                useHeroAnimation: true,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Hero(
                                          tag: row24QuizQuestionsRecord!
                                              .questionPhoto,
                                          transitionOnUserGestures: true,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              row24QuizQuestionsRecord
                                                  .questionPhoto,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if ((FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(23) !=
                                          row24QuizQuestionsRecord
                                              ?.correctAnswerLetter) &&
                                      (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(23) !=
                                              null &&
                                          FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(23) !=
                                              ''))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Twoja odpowiedź: ${FFAppState().selectedOptionsForty.elementAtOrNull(23)}. ${row24QuizQuestionsRecord?.options.elementAtOrNull(() {
                                          if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(23) ==
                                              'A') {
                                            return 0;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(23) ==
                                              'B') {
                                            return 1;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(23) ==
                                              'C') {
                                            return 2;
                                          } else {
                                            return 3;
                                          }
                                        }())}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if (FFAppState()
                                          .selectedOptionsForty
                                          .elementAtOrNull(23) !=
                                      row24QuizQuestionsRecord
                                          ?.correctAnswerLetter)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Poprawna odpowiedź: ${row24QuizQuestionsRecord?.correctAnswerLetter}. ${row24QuizQuestionsRecord?.correctAnswer}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if ((valueOrDefault<bool>(
                                              currentUserDocument
                                                  ?.isUserPremium,
                                              false) ==
                                          true) ||
                                      ((valueOrDefault<bool>(
                                                  currentUserDocument
                                                      ?.isUserPremium,
                                                  false) ==
                                              false) &&
                                          (_model.adWatched == true)))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 12.0),
                                      child: AuthUserStreamWidget(
                                        builder: (context) => Text(
                                          'Wyjaśnienie: ${row24QuizQuestionsRecord?.explenation}',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.manrope(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
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
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                StreamBuilder<List<QuizQuestionsRecord>>(
                  stream: queryQuizQuestionsRecord(
                    queryBuilder: (quizQuestionsRecord) =>
                        quizQuestionsRecord.where(
                      'question_id',
                      isEqualTo:
                          FFAppState().listOfQuestionsID.elementAtOrNull(24),
                    ),
                    singleRecord: true,
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: SpinKitFoldingCube(
                            color: FlutterFlowTheme.of(context).primary,
                            size: 50.0,
                          ),
                        ),
                      );
                    }
                    List<QuizQuestionsRecord> row25QuizQuestionsRecordList =
                        snapshot.data!;
                    // Return an empty Container when the item does not exist.
                    if (snapshot.data!.isEmpty) {
                      return Container();
                    }
                    final row25QuizQuestionsRecord =
                        row25QuizQuestionsRecordList.isNotEmpty
                            ? row25QuizQuestionsRecordList.first
                            : null;

                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 12.0, 16.0, 8.0),
                            child: Container(
                              width: 100.0,
                              decoration: BoxDecoration(
                                color: FFAppState()
                                            .selectedOptionsForty
                                            .elementAtOrNull(24) ==
                                        row25QuizQuestionsRecord
                                            ?.correctAnswerLetter
                                    ? FlutterFlowTheme.of(context)
                                        .correctWithOpacity
                                    : FlutterFlowTheme.of(context)
                                        .wrongAnswerBackground,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15.0),
                                  bottomRight: Radius.circular(15.0),
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                                border: Border.all(
                                  color: FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(24) ==
                                          row25QuizQuestionsRecord
                                              ?.correctAnswerLetter
                                      ? FlutterFlowTheme.of(context).tertiary
                                      : FlutterFlowTheme.of(context)
                                          .wrongAnswerBorder,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      () {
                                        if (row25QuizQuestionsRecord
                                                ?.correctAnswerLetter ==
                                            FFAppState()
                                                .selectedOptionsForty
                                                .elementAtOrNull(24)) {
                                          return 'Poprawna odpowiedź';
                                        } else if (FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(24) ==
                                                null ||
                                            FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(24) ==
                                                '') {
                                          return 'Brak odpowiedzi';
                                        } else {
                                          return 'Błędna odpowiedź';
                                        }
                                      }(),
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      'Treść pytania: ${row25QuizQuestionsRecord?.description}',
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  if (row25QuizQuestionsRecord?.questionPhoto !=
                                          null &&
                                      row25QuizQuestionsRecord?.questionPhoto !=
                                          '')
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
                                              child:
                                                  FlutterFlowExpandedImageView(
                                                image: Image.network(
                                                  row25QuizQuestionsRecord
                                                      .questionPhoto,
                                                  fit: BoxFit.contain,
                                                ),
                                                allowRotation: false,
                                                tag: row25QuizQuestionsRecord
                                                    .questionPhoto,
                                                useHeroAnimation: true,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Hero(
                                          tag: row25QuizQuestionsRecord!
                                              .questionPhoto,
                                          transitionOnUserGestures: true,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              row25QuizQuestionsRecord
                                                  .questionPhoto,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if ((FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(24) !=
                                          row25QuizQuestionsRecord
                                              ?.correctAnswerLetter) &&
                                      (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(24) !=
                                              null &&
                                          FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(24) !=
                                              ''))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Twoja odpowiedź: ${FFAppState().selectedOptionsForty.elementAtOrNull(24)}. ${row25QuizQuestionsRecord?.options.elementAtOrNull(() {
                                          if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(24) ==
                                              'A') {
                                            return 0;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(24) ==
                                              'B') {
                                            return 1;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(24) ==
                                              'C') {
                                            return 2;
                                          } else {
                                            return 3;
                                          }
                                        }())}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if (FFAppState()
                                          .selectedOptionsForty
                                          .elementAtOrNull(24) !=
                                      row25QuizQuestionsRecord
                                          ?.correctAnswerLetter)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Poprawna odpowiedź: ${row25QuizQuestionsRecord?.correctAnswerLetter}. ${row25QuizQuestionsRecord?.correctAnswer}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if ((valueOrDefault<bool>(
                                              currentUserDocument
                                                  ?.isUserPremium,
                                              false) ==
                                          true) ||
                                      ((valueOrDefault<bool>(
                                                  currentUserDocument
                                                      ?.isUserPremium,
                                                  false) ==
                                              false) &&
                                          (_model.adWatched == true)))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 12.0),
                                      child: AuthUserStreamWidget(
                                        builder: (context) => Text(
                                          'Wyjaśnienie: ${row25QuizQuestionsRecord?.explenation}',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.manrope(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
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
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                StreamBuilder<List<QuizQuestionsRecord>>(
                  stream: queryQuizQuestionsRecord(
                    queryBuilder: (quizQuestionsRecord) =>
                        quizQuestionsRecord.where(
                      'question_id',
                      isEqualTo:
                          FFAppState().listOfQuestionsID.elementAtOrNull(25),
                    ),
                    singleRecord: true,
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: SpinKitFoldingCube(
                            color: FlutterFlowTheme.of(context).primary,
                            size: 50.0,
                          ),
                        ),
                      );
                    }
                    List<QuizQuestionsRecord> row26QuizQuestionsRecordList =
                        snapshot.data!;
                    // Return an empty Container when the item does not exist.
                    if (snapshot.data!.isEmpty) {
                      return Container();
                    }
                    final row26QuizQuestionsRecord =
                        row26QuizQuestionsRecordList.isNotEmpty
                            ? row26QuizQuestionsRecordList.first
                            : null;

                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 12.0, 16.0, 8.0),
                            child: Container(
                              width: 100.0,
                              decoration: BoxDecoration(
                                color: FFAppState()
                                            .selectedOptionsForty
                                            .elementAtOrNull(25) ==
                                        row26QuizQuestionsRecord
                                            ?.correctAnswerLetter
                                    ? FlutterFlowTheme.of(context)
                                        .correctWithOpacity
                                    : FlutterFlowTheme.of(context)
                                        .wrongAnswerBackground,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15.0),
                                  bottomRight: Radius.circular(15.0),
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                                border: Border.all(
                                  color: FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(25) ==
                                          row26QuizQuestionsRecord
                                              ?.correctAnswerLetter
                                      ? FlutterFlowTheme.of(context).tertiary
                                      : FlutterFlowTheme.of(context)
                                          .wrongAnswerBorder,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      () {
                                        if (row26QuizQuestionsRecord
                                                ?.correctAnswerLetter ==
                                            FFAppState()
                                                .selectedOptionsForty
                                                .elementAtOrNull(25)) {
                                          return 'Poprawna odpowiedź';
                                        } else if (FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(25) ==
                                                null ||
                                            FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(25) ==
                                                '') {
                                          return 'Brak odpowiedzi';
                                        } else {
                                          return 'Błędna odpowiedź';
                                        }
                                      }(),
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      'Treść pytania: ${row26QuizQuestionsRecord?.description}',
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  if (row26QuizQuestionsRecord?.questionPhoto !=
                                          null &&
                                      row26QuizQuestionsRecord?.questionPhoto !=
                                          '')
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
                                              child:
                                                  FlutterFlowExpandedImageView(
                                                image: Image.network(
                                                  row26QuizQuestionsRecord
                                                      .questionPhoto,
                                                  fit: BoxFit.contain,
                                                ),
                                                allowRotation: false,
                                                tag: row26QuizQuestionsRecord
                                                    .questionPhoto,
                                                useHeroAnimation: true,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Hero(
                                          tag: row26QuizQuestionsRecord!
                                              .questionPhoto,
                                          transitionOnUserGestures: true,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              row26QuizQuestionsRecord
                                                  .questionPhoto,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if ((FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(25) !=
                                          row26QuizQuestionsRecord
                                              ?.correctAnswerLetter) &&
                                      (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(25) !=
                                              null &&
                                          FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(25) !=
                                              ''))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Twoja odpowiedź: ${FFAppState().selectedOptionsForty.elementAtOrNull(25)}. ${row26QuizQuestionsRecord?.options.elementAtOrNull(() {
                                          if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(25) ==
                                              'A') {
                                            return 0;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(25) ==
                                              'B') {
                                            return 1;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(25) ==
                                              'C') {
                                            return 2;
                                          } else {
                                            return 3;
                                          }
                                        }())}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if (FFAppState()
                                          .selectedOptionsForty
                                          .elementAtOrNull(25) !=
                                      row26QuizQuestionsRecord
                                          ?.correctAnswerLetter)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Poprawna odpowiedź: ${row26QuizQuestionsRecord?.correctAnswerLetter}. ${row26QuizQuestionsRecord?.correctAnswer}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if ((valueOrDefault<bool>(
                                              currentUserDocument
                                                  ?.isUserPremium,
                                              false) ==
                                          true) ||
                                      ((valueOrDefault<bool>(
                                                  currentUserDocument
                                                      ?.isUserPremium,
                                                  false) ==
                                              false) &&
                                          (_model.adWatched == true)))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 12.0),
                                      child: AuthUserStreamWidget(
                                        builder: (context) => Text(
                                          'Wyjaśnienie: ${row26QuizQuestionsRecord?.explenation}',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.manrope(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
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
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                StreamBuilder<List<QuizQuestionsRecord>>(
                  stream: queryQuizQuestionsRecord(
                    queryBuilder: (quizQuestionsRecord) =>
                        quizQuestionsRecord.where(
                      'question_id',
                      isEqualTo:
                          FFAppState().listOfQuestionsID.elementAtOrNull(26),
                    ),
                    singleRecord: true,
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: SpinKitFoldingCube(
                            color: FlutterFlowTheme.of(context).primary,
                            size: 50.0,
                          ),
                        ),
                      );
                    }
                    List<QuizQuestionsRecord> row27QuizQuestionsRecordList =
                        snapshot.data!;
                    // Return an empty Container when the item does not exist.
                    if (snapshot.data!.isEmpty) {
                      return Container();
                    }
                    final row27QuizQuestionsRecord =
                        row27QuizQuestionsRecordList.isNotEmpty
                            ? row27QuizQuestionsRecordList.first
                            : null;

                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 12.0, 16.0, 8.0),
                            child: Container(
                              width: 100.0,
                              decoration: BoxDecoration(
                                color: FFAppState()
                                            .selectedOptionsForty
                                            .elementAtOrNull(26) ==
                                        row27QuizQuestionsRecord
                                            ?.correctAnswerLetter
                                    ? FlutterFlowTheme.of(context)
                                        .correctWithOpacity
                                    : FlutterFlowTheme.of(context)
                                        .wrongAnswerBackground,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15.0),
                                  bottomRight: Radius.circular(15.0),
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                                border: Border.all(
                                  color: FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(26) ==
                                          row27QuizQuestionsRecord
                                              ?.correctAnswerLetter
                                      ? FlutterFlowTheme.of(context).tertiary
                                      : FlutterFlowTheme.of(context)
                                          .wrongAnswerBorder,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      () {
                                        if (row27QuizQuestionsRecord
                                                ?.correctAnswerLetter ==
                                            FFAppState()
                                                .selectedOptionsForty
                                                .elementAtOrNull(26)) {
                                          return 'Poprawna odpowiedź';
                                        } else if (FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(26) ==
                                                null ||
                                            FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(26) ==
                                                '') {
                                          return 'Brak odpowiedzi';
                                        } else {
                                          return 'Błędna odpowiedź';
                                        }
                                      }(),
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      'Treść pytania: ${row27QuizQuestionsRecord?.description}',
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  if (row27QuizQuestionsRecord?.questionPhoto !=
                                          null &&
                                      row27QuizQuestionsRecord?.questionPhoto !=
                                          '')
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
                                              child:
                                                  FlutterFlowExpandedImageView(
                                                image: Image.network(
                                                  row27QuizQuestionsRecord
                                                      .questionPhoto,
                                                  fit: BoxFit.contain,
                                                ),
                                                allowRotation: false,
                                                tag: row27QuizQuestionsRecord
                                                    .questionPhoto,
                                                useHeroAnimation: true,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Hero(
                                          tag: row27QuizQuestionsRecord!
                                              .questionPhoto,
                                          transitionOnUserGestures: true,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              row27QuizQuestionsRecord
                                                  .questionPhoto,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if ((FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(26) !=
                                          row27QuizQuestionsRecord
                                              ?.correctAnswerLetter) &&
                                      (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(26) !=
                                              null &&
                                          FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(26) !=
                                              ''))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Twoja odpowiedź: ${FFAppState().selectedOptionsForty.elementAtOrNull(26)}. ${row27QuizQuestionsRecord?.options.elementAtOrNull(() {
                                          if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(26) ==
                                              'A') {
                                            return 0;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(26) ==
                                              'B') {
                                            return 1;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(26) ==
                                              'C') {
                                            return 2;
                                          } else {
                                            return 3;
                                          }
                                        }())}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if (FFAppState()
                                          .selectedOptionsForty
                                          .elementAtOrNull(26) !=
                                      row27QuizQuestionsRecord
                                          ?.correctAnswerLetter)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Poprawna odpowiedź: ${row27QuizQuestionsRecord?.correctAnswerLetter}. ${row27QuizQuestionsRecord?.correctAnswer}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if ((valueOrDefault<bool>(
                                              currentUserDocument
                                                  ?.isUserPremium,
                                              false) ==
                                          true) ||
                                      ((valueOrDefault<bool>(
                                                  currentUserDocument
                                                      ?.isUserPremium,
                                                  false) ==
                                              false) &&
                                          (_model.adWatched == true)))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 12.0),
                                      child: AuthUserStreamWidget(
                                        builder: (context) => Text(
                                          'Wyjaśnienie: ${row27QuizQuestionsRecord?.explenation}',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.manrope(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
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
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                StreamBuilder<List<QuizQuestionsRecord>>(
                  stream: queryQuizQuestionsRecord(
                    queryBuilder: (quizQuestionsRecord) =>
                        quizQuestionsRecord.where(
                      'question_id',
                      isEqualTo:
                          FFAppState().listOfQuestionsID.elementAtOrNull(27),
                    ),
                    singleRecord: true,
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: SpinKitFoldingCube(
                            color: FlutterFlowTheme.of(context).primary,
                            size: 50.0,
                          ),
                        ),
                      );
                    }
                    List<QuizQuestionsRecord> row28QuizQuestionsRecordList =
                        snapshot.data!;
                    // Return an empty Container when the item does not exist.
                    if (snapshot.data!.isEmpty) {
                      return Container();
                    }
                    final row28QuizQuestionsRecord =
                        row28QuizQuestionsRecordList.isNotEmpty
                            ? row28QuizQuestionsRecordList.first
                            : null;

                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 12.0, 16.0, 8.0),
                            child: Container(
                              width: 100.0,
                              decoration: BoxDecoration(
                                color: FFAppState()
                                            .selectedOptionsForty
                                            .elementAtOrNull(27) ==
                                        row28QuizQuestionsRecord
                                            ?.correctAnswerLetter
                                    ? FlutterFlowTheme.of(context)
                                        .correctWithOpacity
                                    : FlutterFlowTheme.of(context)
                                        .wrongAnswerBackground,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15.0),
                                  bottomRight: Radius.circular(15.0),
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                                border: Border.all(
                                  color: FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(27) ==
                                          row28QuizQuestionsRecord
                                              ?.correctAnswerLetter
                                      ? FlutterFlowTheme.of(context).tertiary
                                      : FlutterFlowTheme.of(context)
                                          .wrongAnswerBorder,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      () {
                                        if (row28QuizQuestionsRecord
                                                ?.correctAnswerLetter ==
                                            FFAppState()
                                                .selectedOptionsForty
                                                .elementAtOrNull(27)) {
                                          return 'Poprawna odpowiedź';
                                        } else if (FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(27) ==
                                                null ||
                                            FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(27) ==
                                                '') {
                                          return 'Brak odpowiedzi';
                                        } else {
                                          return 'Błędna odpowiedź';
                                        }
                                      }(),
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      'Treść pytania: ${row28QuizQuestionsRecord?.description}',
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  if (row28QuizQuestionsRecord?.questionPhoto !=
                                          null &&
                                      row28QuizQuestionsRecord?.questionPhoto !=
                                          '')
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
                                              child:
                                                  FlutterFlowExpandedImageView(
                                                image: Image.network(
                                                  row28QuizQuestionsRecord
                                                      .questionPhoto,
                                                  fit: BoxFit.contain,
                                                ),
                                                allowRotation: false,
                                                tag: row28QuizQuestionsRecord
                                                    .questionPhoto,
                                                useHeroAnimation: true,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Hero(
                                          tag: row28QuizQuestionsRecord!
                                              .questionPhoto,
                                          transitionOnUserGestures: true,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              row28QuizQuestionsRecord
                                                  .questionPhoto,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if ((FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(27) !=
                                          row28QuizQuestionsRecord
                                              ?.correctAnswerLetter) &&
                                      (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(27) !=
                                              null &&
                                          FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(27) !=
                                              ''))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Twoja odpowiedź: ${FFAppState().selectedOptionsForty.elementAtOrNull(27)}. ${row28QuizQuestionsRecord?.options.elementAtOrNull(() {
                                          if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(27) ==
                                              'A') {
                                            return 0;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(27) ==
                                              'B') {
                                            return 1;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(27) ==
                                              'C') {
                                            return 2;
                                          } else {
                                            return 3;
                                          }
                                        }())}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if (FFAppState()
                                          .selectedOptionsForty
                                          .elementAtOrNull(27) !=
                                      row28QuizQuestionsRecord
                                          ?.correctAnswerLetter)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Poprawna odpowiedź: ${row28QuizQuestionsRecord?.correctAnswerLetter}. ${row28QuizQuestionsRecord?.correctAnswer}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if ((valueOrDefault<bool>(
                                              currentUserDocument
                                                  ?.isUserPremium,
                                              false) ==
                                          true) ||
                                      ((valueOrDefault<bool>(
                                                  currentUserDocument
                                                      ?.isUserPremium,
                                                  false) ==
                                              false) &&
                                          (_model.adWatched == true)))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 12.0),
                                      child: AuthUserStreamWidget(
                                        builder: (context) => Text(
                                          'Wyjaśnienie: ${row28QuizQuestionsRecord?.explenation}',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.manrope(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
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
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                StreamBuilder<List<QuizQuestionsRecord>>(
                  stream: queryQuizQuestionsRecord(
                    queryBuilder: (quizQuestionsRecord) =>
                        quizQuestionsRecord.where(
                      'question_id',
                      isEqualTo:
                          FFAppState().listOfQuestionsID.elementAtOrNull(28),
                    ),
                    singleRecord: true,
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: SpinKitFoldingCube(
                            color: FlutterFlowTheme.of(context).primary,
                            size: 50.0,
                          ),
                        ),
                      );
                    }
                    List<QuizQuestionsRecord> row29QuizQuestionsRecordList =
                        snapshot.data!;
                    // Return an empty Container when the item does not exist.
                    if (snapshot.data!.isEmpty) {
                      return Container();
                    }
                    final row29QuizQuestionsRecord =
                        row29QuizQuestionsRecordList.isNotEmpty
                            ? row29QuizQuestionsRecordList.first
                            : null;

                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 12.0, 16.0, 8.0),
                            child: Container(
                              width: 100.0,
                              decoration: BoxDecoration(
                                color: FFAppState()
                                            .selectedOptionsForty
                                            .elementAtOrNull(28) ==
                                        row29QuizQuestionsRecord
                                            ?.correctAnswerLetter
                                    ? FlutterFlowTheme.of(context)
                                        .correctWithOpacity
                                    : FlutterFlowTheme.of(context)
                                        .wrongAnswerBackground,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15.0),
                                  bottomRight: Radius.circular(15.0),
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                                border: Border.all(
                                  color: FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(28) ==
                                          row29QuizQuestionsRecord
                                              ?.correctAnswerLetter
                                      ? FlutterFlowTheme.of(context).tertiary
                                      : FlutterFlowTheme.of(context)
                                          .wrongAnswerBorder,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      () {
                                        if (row29QuizQuestionsRecord
                                                ?.correctAnswerLetter ==
                                            FFAppState()
                                                .selectedOptionsForty
                                                .elementAtOrNull(28)) {
                                          return 'Poprawna odpowiedź';
                                        } else if (FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(28) ==
                                                null ||
                                            FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(28) ==
                                                '') {
                                          return 'Brak odpowiedzi';
                                        } else {
                                          return 'Błędna odpowiedź';
                                        }
                                      }(),
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      'Treść pytania: ${row29QuizQuestionsRecord?.description}',
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  if (row29QuizQuestionsRecord?.questionPhoto !=
                                          null &&
                                      row29QuizQuestionsRecord?.questionPhoto !=
                                          '')
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
                                              child:
                                                  FlutterFlowExpandedImageView(
                                                image: Image.network(
                                                  row29QuizQuestionsRecord
                                                      .questionPhoto,
                                                  fit: BoxFit.contain,
                                                ),
                                                allowRotation: false,
                                                tag: row29QuizQuestionsRecord
                                                    .questionPhoto,
                                                useHeroAnimation: true,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Hero(
                                          tag: row29QuizQuestionsRecord!
                                              .questionPhoto,
                                          transitionOnUserGestures: true,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              row29QuizQuestionsRecord
                                                  .questionPhoto,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if ((FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(28) !=
                                          row29QuizQuestionsRecord
                                              ?.correctAnswerLetter) &&
                                      (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(28) !=
                                              null &&
                                          FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(28) !=
                                              ''))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Twoja odpowiedź: ${FFAppState().selectedOptionsForty.elementAtOrNull(28)}. ${row29QuizQuestionsRecord?.options.elementAtOrNull(() {
                                          if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(28) ==
                                              'A') {
                                            return 0;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(28) ==
                                              'B') {
                                            return 1;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(28) ==
                                              'C') {
                                            return 2;
                                          } else {
                                            return 3;
                                          }
                                        }())}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if (FFAppState()
                                          .selectedOptionsForty
                                          .elementAtOrNull(28) !=
                                      row29QuizQuestionsRecord
                                          ?.correctAnswerLetter)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Poprawna odpowiedź: ${row29QuizQuestionsRecord?.correctAnswerLetter}. ${row29QuizQuestionsRecord?.correctAnswer}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if ((valueOrDefault<bool>(
                                              currentUserDocument
                                                  ?.isUserPremium,
                                              false) ==
                                          true) ||
                                      ((valueOrDefault<bool>(
                                                  currentUserDocument
                                                      ?.isUserPremium,
                                                  false) ==
                                              false) &&
                                          (_model.adWatched == true)))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 12.0),
                                      child: AuthUserStreamWidget(
                                        builder: (context) => Text(
                                          'Wyjaśnienie: ${row29QuizQuestionsRecord?.explenation}',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.manrope(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
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
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                StreamBuilder<List<QuizQuestionsRecord>>(
                  stream: queryQuizQuestionsRecord(
                    queryBuilder: (quizQuestionsRecord) =>
                        quizQuestionsRecord.where(
                      'question_id',
                      isEqualTo:
                          FFAppState().listOfQuestionsID.elementAtOrNull(29),
                    ),
                    singleRecord: true,
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: SpinKitFoldingCube(
                            color: FlutterFlowTheme.of(context).primary,
                            size: 50.0,
                          ),
                        ),
                      );
                    }
                    List<QuizQuestionsRecord> row30QuizQuestionsRecordList =
                        snapshot.data!;
                    // Return an empty Container when the item does not exist.
                    if (snapshot.data!.isEmpty) {
                      return Container();
                    }
                    final row30QuizQuestionsRecord =
                        row30QuizQuestionsRecordList.isNotEmpty
                            ? row30QuizQuestionsRecordList.first
                            : null;

                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 12.0, 16.0, 8.0),
                            child: Container(
                              width: 100.0,
                              decoration: BoxDecoration(
                                color: FFAppState()
                                            .selectedOptionsForty
                                            .elementAtOrNull(29) ==
                                        row30QuizQuestionsRecord
                                            ?.correctAnswerLetter
                                    ? FlutterFlowTheme.of(context)
                                        .correctWithOpacity
                                    : FlutterFlowTheme.of(context)
                                        .wrongAnswerBackground,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15.0),
                                  bottomRight: Radius.circular(15.0),
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                                border: Border.all(
                                  color: FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(29) ==
                                          row30QuizQuestionsRecord
                                              ?.correctAnswerLetter
                                      ? FlutterFlowTheme.of(context).tertiary
                                      : FlutterFlowTheme.of(context)
                                          .wrongAnswerBorder,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      () {
                                        if (row30QuizQuestionsRecord
                                                ?.correctAnswerLetter ==
                                            FFAppState()
                                                .selectedOptionsForty
                                                .elementAtOrNull(29)) {
                                          return 'Poprawna odpowiedź';
                                        } else if (FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(29) ==
                                                null ||
                                            FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(29) ==
                                                '') {
                                          return 'Brak odpowiedzi';
                                        } else {
                                          return 'Błędna odpowiedź';
                                        }
                                      }(),
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      'Treść pytania: ${row30QuizQuestionsRecord?.description}',
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  if (row30QuizQuestionsRecord?.questionPhoto !=
                                          null &&
                                      row30QuizQuestionsRecord?.questionPhoto !=
                                          '')
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
                                              child:
                                                  FlutterFlowExpandedImageView(
                                                image: Image.network(
                                                  row30QuizQuestionsRecord
                                                      .questionPhoto,
                                                  fit: BoxFit.contain,
                                                ),
                                                allowRotation: false,
                                                tag: row30QuizQuestionsRecord
                                                    .questionPhoto,
                                                useHeroAnimation: true,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Hero(
                                          tag: row30QuizQuestionsRecord!
                                              .questionPhoto,
                                          transitionOnUserGestures: true,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              row30QuizQuestionsRecord
                                                  .questionPhoto,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if ((FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(29) !=
                                          row30QuizQuestionsRecord
                                              ?.correctAnswerLetter) &&
                                      (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(29) !=
                                              null &&
                                          FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(29) !=
                                              ''))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Twoja odpowiedź: ${FFAppState().selectedOptionsForty.elementAtOrNull(29)}. ${row30QuizQuestionsRecord?.options.elementAtOrNull(() {
                                          if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(29) ==
                                              'A') {
                                            return 0;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(29) ==
                                              'B') {
                                            return 1;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(29) ==
                                              'C') {
                                            return 2;
                                          } else {
                                            return 3;
                                          }
                                        }())}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if (FFAppState()
                                          .selectedOptionsForty
                                          .elementAtOrNull(29) !=
                                      row30QuizQuestionsRecord
                                          ?.correctAnswerLetter)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Poprawna odpowiedź: ${row30QuizQuestionsRecord?.correctAnswerLetter}. ${row30QuizQuestionsRecord?.correctAnswer}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if ((valueOrDefault<bool>(
                                              currentUserDocument
                                                  ?.isUserPremium,
                                              false) ==
                                          true) ||
                                      ((valueOrDefault<bool>(
                                                  currentUserDocument
                                                      ?.isUserPremium,
                                                  false) ==
                                              false) &&
                                          (_model.adWatched == true)))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 12.0),
                                      child: AuthUserStreamWidget(
                                        builder: (context) => Text(
                                          'Wyjaśnienie: ${row30QuizQuestionsRecord?.explenation}',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.manrope(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
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
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                StreamBuilder<List<QuizQuestionsRecord>>(
                  stream: queryQuizQuestionsRecord(
                    queryBuilder: (quizQuestionsRecord) =>
                        quizQuestionsRecord.where(
                      'question_id',
                      isEqualTo:
                          FFAppState().listOfQuestionsID.elementAtOrNull(30),
                    ),
                    singleRecord: true,
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: SpinKitFoldingCube(
                            color: FlutterFlowTheme.of(context).primary,
                            size: 50.0,
                          ),
                        ),
                      );
                    }
                    List<QuizQuestionsRecord> row31QuizQuestionsRecordList =
                        snapshot.data!;
                    // Return an empty Container when the item does not exist.
                    if (snapshot.data!.isEmpty) {
                      return Container();
                    }
                    final row31QuizQuestionsRecord =
                        row31QuizQuestionsRecordList.isNotEmpty
                            ? row31QuizQuestionsRecordList.first
                            : null;

                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 12.0, 16.0, 8.0),
                            child: Container(
                              width: 100.0,
                              decoration: BoxDecoration(
                                color: FFAppState()
                                            .selectedOptionsForty
                                            .elementAtOrNull(30) ==
                                        row31QuizQuestionsRecord
                                            ?.correctAnswerLetter
                                    ? FlutterFlowTheme.of(context)
                                        .correctWithOpacity
                                    : FlutterFlowTheme.of(context)
                                        .wrongAnswerBackground,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15.0),
                                  bottomRight: Radius.circular(15.0),
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                                border: Border.all(
                                  color: FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(30) ==
                                          row31QuizQuestionsRecord
                                              ?.correctAnswerLetter
                                      ? FlutterFlowTheme.of(context).tertiary
                                      : FlutterFlowTheme.of(context)
                                          .wrongAnswerBorder,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      () {
                                        if (row31QuizQuestionsRecord
                                                ?.correctAnswerLetter ==
                                            FFAppState()
                                                .selectedOptionsForty
                                                .elementAtOrNull(30)) {
                                          return 'Poprawna odpowiedź';
                                        } else if (FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(30) ==
                                                null ||
                                            FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(30) ==
                                                '') {
                                          return 'Brak odpowiedzi';
                                        } else {
                                          return 'Błędna odpowiedź';
                                        }
                                      }(),
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      'Treść pytania: ${row31QuizQuestionsRecord?.description}',
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  if (row31QuizQuestionsRecord?.questionPhoto !=
                                          null &&
                                      row31QuizQuestionsRecord?.questionPhoto !=
                                          '')
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
                                              child:
                                                  FlutterFlowExpandedImageView(
                                                image: Image.network(
                                                  row31QuizQuestionsRecord
                                                      .questionPhoto,
                                                  fit: BoxFit.contain,
                                                ),
                                                allowRotation: false,
                                                tag: row31QuizQuestionsRecord
                                                    .questionPhoto,
                                                useHeroAnimation: true,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Hero(
                                          tag: row31QuizQuestionsRecord!
                                              .questionPhoto,
                                          transitionOnUserGestures: true,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              row31QuizQuestionsRecord
                                                  .questionPhoto,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if ((FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(30) !=
                                          row31QuizQuestionsRecord
                                              ?.correctAnswerLetter) &&
                                      (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(30) !=
                                              null &&
                                          FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(30) !=
                                              ''))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Twoja odpowiedź: ${FFAppState().selectedOptionsForty.elementAtOrNull(30)}. ${row31QuizQuestionsRecord?.options.elementAtOrNull(() {
                                          if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(30) ==
                                              'A') {
                                            return 0;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(30) ==
                                              'B') {
                                            return 1;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(30) ==
                                              'C') {
                                            return 2;
                                          } else {
                                            return 3;
                                          }
                                        }())}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if (FFAppState()
                                          .selectedOptionsForty
                                          .elementAtOrNull(30) !=
                                      row31QuizQuestionsRecord
                                          ?.correctAnswerLetter)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Poprawna odpowiedź: ${row31QuizQuestionsRecord?.correctAnswerLetter}. ${row31QuizQuestionsRecord?.correctAnswer}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if ((valueOrDefault<bool>(
                                              currentUserDocument
                                                  ?.isUserPremium,
                                              false) ==
                                          true) ||
                                      ((valueOrDefault<bool>(
                                                  currentUserDocument
                                                      ?.isUserPremium,
                                                  false) ==
                                              false) &&
                                          (_model.adWatched == true)))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 12.0),
                                      child: AuthUserStreamWidget(
                                        builder: (context) => Text(
                                          'Wyjaśnienie: ${row31QuizQuestionsRecord?.explenation}',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.manrope(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
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
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                StreamBuilder<List<QuizQuestionsRecord>>(
                  stream: queryQuizQuestionsRecord(
                    queryBuilder: (quizQuestionsRecord) =>
                        quizQuestionsRecord.where(
                      'question_id',
                      isEqualTo:
                          FFAppState().listOfQuestionsID.elementAtOrNull(31),
                    ),
                    singleRecord: true,
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: SpinKitFoldingCube(
                            color: FlutterFlowTheme.of(context).primary,
                            size: 50.0,
                          ),
                        ),
                      );
                    }
                    List<QuizQuestionsRecord> row32QuizQuestionsRecordList =
                        snapshot.data!;
                    // Return an empty Container when the item does not exist.
                    if (snapshot.data!.isEmpty) {
                      return Container();
                    }
                    final row32QuizQuestionsRecord =
                        row32QuizQuestionsRecordList.isNotEmpty
                            ? row32QuizQuestionsRecordList.first
                            : null;

                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 12.0, 16.0, 8.0),
                            child: Container(
                              width: 100.0,
                              decoration: BoxDecoration(
                                color: FFAppState()
                                            .selectedOptionsForty
                                            .elementAtOrNull(31) ==
                                        row32QuizQuestionsRecord
                                            ?.correctAnswerLetter
                                    ? FlutterFlowTheme.of(context)
                                        .correctWithOpacity
                                    : FlutterFlowTheme.of(context)
                                        .wrongAnswerBackground,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15.0),
                                  bottomRight: Radius.circular(15.0),
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                                border: Border.all(
                                  color: FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(31) ==
                                          row32QuizQuestionsRecord
                                              ?.correctAnswerLetter
                                      ? FlutterFlowTheme.of(context).tertiary
                                      : FlutterFlowTheme.of(context)
                                          .wrongAnswerBorder,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      () {
                                        if (row32QuizQuestionsRecord
                                                ?.correctAnswerLetter ==
                                            FFAppState()
                                                .selectedOptionsForty
                                                .elementAtOrNull(31)) {
                                          return 'Poprawna odpowiedź';
                                        } else if (FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(31) ==
                                                null ||
                                            FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(31) ==
                                                '') {
                                          return 'Brak odpowiedzi';
                                        } else {
                                          return 'Błędna odpowiedź';
                                        }
                                      }(),
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      'Treść pytania: ${row32QuizQuestionsRecord?.description}',
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  if (row32QuizQuestionsRecord?.questionPhoto !=
                                          null &&
                                      row32QuizQuestionsRecord?.questionPhoto !=
                                          '')
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
                                              child:
                                                  FlutterFlowExpandedImageView(
                                                image: Image.network(
                                                  row32QuizQuestionsRecord
                                                      .questionPhoto,
                                                  fit: BoxFit.contain,
                                                ),
                                                allowRotation: false,
                                                tag: row32QuizQuestionsRecord
                                                    .questionPhoto,
                                                useHeroAnimation: true,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Hero(
                                          tag: row32QuizQuestionsRecord!
                                              .questionPhoto,
                                          transitionOnUserGestures: true,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              row32QuizQuestionsRecord
                                                  .questionPhoto,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if ((FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(31) !=
                                          row32QuizQuestionsRecord
                                              ?.correctAnswerLetter) &&
                                      (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(31) !=
                                              null &&
                                          FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(31) !=
                                              ''))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Twoja odpowiedź: ${FFAppState().selectedOptionsForty.elementAtOrNull(31)}. ${row32QuizQuestionsRecord?.options.elementAtOrNull(() {
                                          if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(31) ==
                                              'A') {
                                            return 0;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(31) ==
                                              'B') {
                                            return 1;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(31) ==
                                              'C') {
                                            return 2;
                                          } else {
                                            return 3;
                                          }
                                        }())}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if (FFAppState()
                                          .selectedOptionsForty
                                          .elementAtOrNull(31) !=
                                      row32QuizQuestionsRecord
                                          ?.correctAnswerLetter)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Poprawna odpowiedź: ${row32QuizQuestionsRecord?.correctAnswerLetter}. ${row32QuizQuestionsRecord?.correctAnswer}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if ((valueOrDefault<bool>(
                                              currentUserDocument
                                                  ?.isUserPremium,
                                              false) ==
                                          true) ||
                                      ((valueOrDefault<bool>(
                                                  currentUserDocument
                                                      ?.isUserPremium,
                                                  false) ==
                                              false) &&
                                          (_model.adWatched == true)))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 12.0),
                                      child: AuthUserStreamWidget(
                                        builder: (context) => Text(
                                          'Wyjaśnienie: ${row32QuizQuestionsRecord?.explenation}',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.manrope(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
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
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                StreamBuilder<List<QuizQuestionsRecord>>(
                  stream: queryQuizQuestionsRecord(
                    queryBuilder: (quizQuestionsRecord) =>
                        quizQuestionsRecord.where(
                      'question_id',
                      isEqualTo:
                          FFAppState().listOfQuestionsID.elementAtOrNull(32),
                    ),
                    singleRecord: true,
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: SpinKitFoldingCube(
                            color: FlutterFlowTheme.of(context).primary,
                            size: 50.0,
                          ),
                        ),
                      );
                    }
                    List<QuizQuestionsRecord> row33QuizQuestionsRecordList =
                        snapshot.data!;
                    // Return an empty Container when the item does not exist.
                    if (snapshot.data!.isEmpty) {
                      return Container();
                    }
                    final row33QuizQuestionsRecord =
                        row33QuizQuestionsRecordList.isNotEmpty
                            ? row33QuizQuestionsRecordList.first
                            : null;

                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 12.0, 16.0, 8.0),
                            child: Container(
                              width: 100.0,
                              decoration: BoxDecoration(
                                color: FFAppState()
                                            .selectedOptionsForty
                                            .elementAtOrNull(32) ==
                                        row33QuizQuestionsRecord
                                            ?.correctAnswerLetter
                                    ? FlutterFlowTheme.of(context)
                                        .correctWithOpacity
                                    : FlutterFlowTheme.of(context)
                                        .wrongAnswerBackground,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15.0),
                                  bottomRight: Radius.circular(15.0),
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                                border: Border.all(
                                  color: FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(32) ==
                                          row33QuizQuestionsRecord
                                              ?.correctAnswerLetter
                                      ? FlutterFlowTheme.of(context).tertiary
                                      : FlutterFlowTheme.of(context)
                                          .wrongAnswerBorder,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      () {
                                        if (row33QuizQuestionsRecord
                                                ?.correctAnswerLetter ==
                                            FFAppState()
                                                .selectedOptionsForty
                                                .elementAtOrNull(32)) {
                                          return 'Poprawna odpowiedź';
                                        } else if (FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(32) ==
                                                null ||
                                            FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(32) ==
                                                '') {
                                          return 'Brak odpowiedzi';
                                        } else {
                                          return 'Błędna odpowiedź';
                                        }
                                      }(),
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      'Treść pytania: ${row33QuizQuestionsRecord?.description}',
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  if (row33QuizQuestionsRecord?.questionPhoto !=
                                          null &&
                                      row33QuizQuestionsRecord?.questionPhoto !=
                                          '')
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
                                              child:
                                                  FlutterFlowExpandedImageView(
                                                image: Image.network(
                                                  row33QuizQuestionsRecord
                                                      .questionPhoto,
                                                  fit: BoxFit.contain,
                                                ),
                                                allowRotation: false,
                                                tag: row33QuizQuestionsRecord
                                                    .questionPhoto,
                                                useHeroAnimation: true,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Hero(
                                          tag: row33QuizQuestionsRecord!
                                              .questionPhoto,
                                          transitionOnUserGestures: true,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              row33QuizQuestionsRecord
                                                  .questionPhoto,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if ((FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(32) !=
                                          row33QuizQuestionsRecord
                                              ?.correctAnswerLetter) &&
                                      (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(32) !=
                                              null &&
                                          FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(32) !=
                                              ''))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Twoja odpowiedź: ${FFAppState().selectedOptionsForty.elementAtOrNull(32)}. ${row33QuizQuestionsRecord?.options.elementAtOrNull(() {
                                          if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(32) ==
                                              'A') {
                                            return 0;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(32) ==
                                              'B') {
                                            return 1;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(32) ==
                                              'C') {
                                            return 2;
                                          } else {
                                            return 3;
                                          }
                                        }())}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if (FFAppState()
                                          .selectedOptionsForty
                                          .elementAtOrNull(32) !=
                                      row33QuizQuestionsRecord
                                          ?.correctAnswerLetter)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Poprawna odpowiedź: ${row33QuizQuestionsRecord?.correctAnswerLetter}. ${row33QuizQuestionsRecord?.correctAnswer}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if ((valueOrDefault<bool>(
                                              currentUserDocument
                                                  ?.isUserPremium,
                                              false) ==
                                          true) ||
                                      ((valueOrDefault<bool>(
                                                  currentUserDocument
                                                      ?.isUserPremium,
                                                  false) ==
                                              false) &&
                                          (_model.adWatched == true)))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 12.0),
                                      child: AuthUserStreamWidget(
                                        builder: (context) => Text(
                                          'Wyjaśnienie: ${row33QuizQuestionsRecord?.explenation}',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.manrope(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
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
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                StreamBuilder<List<QuizQuestionsRecord>>(
                  stream: queryQuizQuestionsRecord(
                    queryBuilder: (quizQuestionsRecord) =>
                        quizQuestionsRecord.where(
                      'question_id',
                      isEqualTo:
                          FFAppState().listOfQuestionsID.elementAtOrNull(33),
                    ),
                    singleRecord: true,
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: SpinKitFoldingCube(
                            color: FlutterFlowTheme.of(context).primary,
                            size: 50.0,
                          ),
                        ),
                      );
                    }
                    List<QuizQuestionsRecord> row34QuizQuestionsRecordList =
                        snapshot.data!;
                    // Return an empty Container when the item does not exist.
                    if (snapshot.data!.isEmpty) {
                      return Container();
                    }
                    final row34QuizQuestionsRecord =
                        row34QuizQuestionsRecordList.isNotEmpty
                            ? row34QuizQuestionsRecordList.first
                            : null;

                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 12.0, 16.0, 8.0),
                            child: Container(
                              width: 100.0,
                              decoration: BoxDecoration(
                                color: FFAppState()
                                            .selectedOptionsForty
                                            .elementAtOrNull(33) ==
                                        row34QuizQuestionsRecord
                                            ?.correctAnswerLetter
                                    ? FlutterFlowTheme.of(context)
                                        .correctWithOpacity
                                    : FlutterFlowTheme.of(context)
                                        .wrongAnswerBackground,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15.0),
                                  bottomRight: Radius.circular(15.0),
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                                border: Border.all(
                                  color: FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(33) ==
                                          row34QuizQuestionsRecord
                                              ?.correctAnswerLetter
                                      ? FlutterFlowTheme.of(context).tertiary
                                      : FlutterFlowTheme.of(context)
                                          .wrongAnswerBorder,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      () {
                                        if (row34QuizQuestionsRecord
                                                ?.correctAnswerLetter ==
                                            FFAppState()
                                                .selectedOptionsForty
                                                .elementAtOrNull(33)) {
                                          return 'Poprawna odpowiedź';
                                        } else if (FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(33) ==
                                                null ||
                                            FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(33) ==
                                                '') {
                                          return 'Brak odpowiedzi';
                                        } else {
                                          return 'Błędna odpowiedź';
                                        }
                                      }(),
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      'Treść pytania: ${row34QuizQuestionsRecord?.description}',
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  if (row34QuizQuestionsRecord?.questionPhoto !=
                                          null &&
                                      row34QuizQuestionsRecord?.questionPhoto !=
                                          '')
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
                                              child:
                                                  FlutterFlowExpandedImageView(
                                                image: Image.network(
                                                  row34QuizQuestionsRecord
                                                      .questionPhoto,
                                                  fit: BoxFit.contain,
                                                ),
                                                allowRotation: false,
                                                tag: row34QuizQuestionsRecord
                                                    .questionPhoto,
                                                useHeroAnimation: true,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Hero(
                                          tag: row34QuizQuestionsRecord!
                                              .questionPhoto,
                                          transitionOnUserGestures: true,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              row34QuizQuestionsRecord
                                                  .questionPhoto,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if ((FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(33) !=
                                          row34QuizQuestionsRecord
                                              ?.correctAnswerLetter) &&
                                      (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(33) !=
                                              null &&
                                          FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(33) !=
                                              ''))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Twoja odpowiedź: ${FFAppState().selectedOptionsForty.elementAtOrNull(33)}. ${row34QuizQuestionsRecord?.options.elementAtOrNull(() {
                                          if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(33) ==
                                              'A') {
                                            return 0;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(33) ==
                                              'B') {
                                            return 1;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(33) ==
                                              'C') {
                                            return 2;
                                          } else {
                                            return 3;
                                          }
                                        }())}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if (FFAppState()
                                          .selectedOptionsForty
                                          .elementAtOrNull(33) !=
                                      row34QuizQuestionsRecord
                                          ?.correctAnswerLetter)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Poprawna odpowiedź: ${row34QuizQuestionsRecord?.correctAnswerLetter}. ${row34QuizQuestionsRecord?.correctAnswer}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if ((valueOrDefault<bool>(
                                              currentUserDocument
                                                  ?.isUserPremium,
                                              false) ==
                                          true) ||
                                      ((valueOrDefault<bool>(
                                                  currentUserDocument
                                                      ?.isUserPremium,
                                                  false) ==
                                              false) &&
                                          (_model.adWatched == true)))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 12.0),
                                      child: AuthUserStreamWidget(
                                        builder: (context) => Text(
                                          'Wyjaśnienie: ${row34QuizQuestionsRecord?.explenation}',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.manrope(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
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
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                StreamBuilder<List<QuizQuestionsRecord>>(
                  stream: queryQuizQuestionsRecord(
                    queryBuilder: (quizQuestionsRecord) =>
                        quizQuestionsRecord.where(
                      'question_id',
                      isEqualTo:
                          FFAppState().listOfQuestionsID.elementAtOrNull(34),
                    ),
                    singleRecord: true,
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: SpinKitFoldingCube(
                            color: FlutterFlowTheme.of(context).primary,
                            size: 50.0,
                          ),
                        ),
                      );
                    }
                    List<QuizQuestionsRecord> row35QuizQuestionsRecordList =
                        snapshot.data!;
                    // Return an empty Container when the item does not exist.
                    if (snapshot.data!.isEmpty) {
                      return Container();
                    }
                    final row35QuizQuestionsRecord =
                        row35QuizQuestionsRecordList.isNotEmpty
                            ? row35QuizQuestionsRecordList.first
                            : null;

                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 12.0, 16.0, 8.0),
                            child: Container(
                              width: 100.0,
                              decoration: BoxDecoration(
                                color: FFAppState()
                                            .selectedOptionsForty
                                            .elementAtOrNull(34) ==
                                        row35QuizQuestionsRecord
                                            ?.correctAnswerLetter
                                    ? FlutterFlowTheme.of(context)
                                        .correctWithOpacity
                                    : FlutterFlowTheme.of(context)
                                        .wrongAnswerBackground,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15.0),
                                  bottomRight: Radius.circular(15.0),
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                                border: Border.all(
                                  color: FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(34) ==
                                          row35QuizQuestionsRecord
                                              ?.correctAnswerLetter
                                      ? FlutterFlowTheme.of(context).tertiary
                                      : FlutterFlowTheme.of(context)
                                          .wrongAnswerBorder,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      () {
                                        if (row35QuizQuestionsRecord
                                                ?.correctAnswerLetter ==
                                            FFAppState()
                                                .selectedOptionsForty
                                                .elementAtOrNull(34)) {
                                          return 'Poprawna odpowiedź';
                                        } else if (FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(34) ==
                                                null ||
                                            FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(34) ==
                                                '') {
                                          return 'Brak odpowiedzi';
                                        } else {
                                          return 'Błędna odpowiedź';
                                        }
                                      }(),
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      'Treść pytania: ${row35QuizQuestionsRecord?.description}',
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  if (row35QuizQuestionsRecord?.questionPhoto !=
                                          null &&
                                      row35QuizQuestionsRecord?.questionPhoto !=
                                          '')
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
                                              child:
                                                  FlutterFlowExpandedImageView(
                                                image: Image.network(
                                                  row35QuizQuestionsRecord
                                                      .questionPhoto,
                                                  fit: BoxFit.contain,
                                                ),
                                                allowRotation: false,
                                                tag: row35QuizQuestionsRecord
                                                    .questionPhoto,
                                                useHeroAnimation: true,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Hero(
                                          tag: row35QuizQuestionsRecord!
                                              .questionPhoto,
                                          transitionOnUserGestures: true,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              row35QuizQuestionsRecord
                                                  .questionPhoto,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if ((FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(34) !=
                                          row35QuizQuestionsRecord
                                              ?.correctAnswerLetter) &&
                                      (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(34) !=
                                              null &&
                                          FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(34) !=
                                              ''))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Twoja odpowiedź: ${FFAppState().selectedOptionsForty.elementAtOrNull(34)}. ${row35QuizQuestionsRecord?.options.elementAtOrNull(() {
                                          if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(34) ==
                                              'A') {
                                            return 0;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(34) ==
                                              'B') {
                                            return 1;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(34) ==
                                              'C') {
                                            return 2;
                                          } else {
                                            return 3;
                                          }
                                        }())}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if (FFAppState()
                                          .selectedOptionsForty
                                          .elementAtOrNull(34) !=
                                      row35QuizQuestionsRecord
                                          ?.correctAnswerLetter)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Poprawna odpowiedź: ${row35QuizQuestionsRecord?.correctAnswerLetter}. ${row35QuizQuestionsRecord?.correctAnswer}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if ((valueOrDefault<bool>(
                                              currentUserDocument
                                                  ?.isUserPremium,
                                              false) ==
                                          true) ||
                                      ((valueOrDefault<bool>(
                                                  currentUserDocument
                                                      ?.isUserPremium,
                                                  false) ==
                                              false) &&
                                          (_model.adWatched == true)))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 12.0),
                                      child: AuthUserStreamWidget(
                                        builder: (context) => Text(
                                          'Wyjaśnienie: ${row35QuizQuestionsRecord?.explenation}',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.manrope(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
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
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                StreamBuilder<List<QuizQuestionsRecord>>(
                  stream: queryQuizQuestionsRecord(
                    queryBuilder: (quizQuestionsRecord) =>
                        quizQuestionsRecord.where(
                      'question_id',
                      isEqualTo:
                          FFAppState().listOfQuestionsID.elementAtOrNull(35),
                    ),
                    singleRecord: true,
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: SpinKitFoldingCube(
                            color: FlutterFlowTheme.of(context).primary,
                            size: 50.0,
                          ),
                        ),
                      );
                    }
                    List<QuizQuestionsRecord> row36QuizQuestionsRecordList =
                        snapshot.data!;
                    // Return an empty Container when the item does not exist.
                    if (snapshot.data!.isEmpty) {
                      return Container();
                    }
                    final row36QuizQuestionsRecord =
                        row36QuizQuestionsRecordList.isNotEmpty
                            ? row36QuizQuestionsRecordList.first
                            : null;

                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 12.0, 16.0, 8.0),
                            child: Container(
                              width: 100.0,
                              decoration: BoxDecoration(
                                color: FFAppState()
                                            .selectedOptionsForty
                                            .elementAtOrNull(35) ==
                                        row36QuizQuestionsRecord
                                            ?.correctAnswerLetter
                                    ? FlutterFlowTheme.of(context)
                                        .correctWithOpacity
                                    : FlutterFlowTheme.of(context)
                                        .wrongAnswerBackground,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15.0),
                                  bottomRight: Radius.circular(15.0),
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                                border: Border.all(
                                  color: FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(35) ==
                                          row36QuizQuestionsRecord
                                              ?.correctAnswerLetter
                                      ? FlutterFlowTheme.of(context).tertiary
                                      : FlutterFlowTheme.of(context)
                                          .wrongAnswerBorder,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      () {
                                        if (row36QuizQuestionsRecord
                                                ?.correctAnswerLetter ==
                                            FFAppState()
                                                .selectedOptionsForty
                                                .elementAtOrNull(35)) {
                                          return 'Poprawna odpowiedź';
                                        } else if (FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(35) ==
                                                null ||
                                            FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(35) ==
                                                '') {
                                          return 'Brak odpowiedzi';
                                        } else {
                                          return 'Błędna odpowiedź';
                                        }
                                      }(),
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      'Treść pytania: ${row36QuizQuestionsRecord?.description}',
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  if (row36QuizQuestionsRecord?.questionPhoto !=
                                          null &&
                                      row36QuizQuestionsRecord?.questionPhoto !=
                                          '')
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
                                              child:
                                                  FlutterFlowExpandedImageView(
                                                image: Image.network(
                                                  row36QuizQuestionsRecord
                                                      .questionPhoto,
                                                  fit: BoxFit.contain,
                                                ),
                                                allowRotation: false,
                                                tag: row36QuizQuestionsRecord
                                                    .questionPhoto,
                                                useHeroAnimation: true,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Hero(
                                          tag: row36QuizQuestionsRecord!
                                              .questionPhoto,
                                          transitionOnUserGestures: true,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              row36QuizQuestionsRecord
                                                  .questionPhoto,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if ((FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(35) !=
                                          row36QuizQuestionsRecord
                                              ?.correctAnswerLetter) &&
                                      (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(35) !=
                                              null &&
                                          FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(35) !=
                                              ''))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Twoja odpowiedź: ${FFAppState().selectedOptionsForty.elementAtOrNull(35)}. ${row36QuizQuestionsRecord?.options.elementAtOrNull(() {
                                          if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(35) ==
                                              'A') {
                                            return 0;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(35) ==
                                              'B') {
                                            return 1;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(35) ==
                                              'C') {
                                            return 2;
                                          } else {
                                            return 3;
                                          }
                                        }())}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if (FFAppState()
                                          .selectedOptionsForty
                                          .elementAtOrNull(35) !=
                                      row36QuizQuestionsRecord
                                          ?.correctAnswerLetter)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Poprawna odpowiedź: ${row36QuizQuestionsRecord?.correctAnswerLetter}. ${row36QuizQuestionsRecord?.correctAnswer}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if ((valueOrDefault<bool>(
                                              currentUserDocument
                                                  ?.isUserPremium,
                                              false) ==
                                          true) ||
                                      ((valueOrDefault<bool>(
                                                  currentUserDocument
                                                      ?.isUserPremium,
                                                  false) ==
                                              false) &&
                                          (_model.adWatched == true)))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 12.0),
                                      child: AuthUserStreamWidget(
                                        builder: (context) => Text(
                                          'Wyjaśnienie: ${row36QuizQuestionsRecord?.explenation}',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.manrope(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
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
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                StreamBuilder<List<QuizQuestionsRecord>>(
                  stream: queryQuizQuestionsRecord(
                    queryBuilder: (quizQuestionsRecord) =>
                        quizQuestionsRecord.where(
                      'question_id',
                      isEqualTo:
                          FFAppState().listOfQuestionsID.elementAtOrNull(36),
                    ),
                    singleRecord: true,
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: SpinKitFoldingCube(
                            color: FlutterFlowTheme.of(context).primary,
                            size: 50.0,
                          ),
                        ),
                      );
                    }
                    List<QuizQuestionsRecord> row37QuizQuestionsRecordList =
                        snapshot.data!;
                    // Return an empty Container when the item does not exist.
                    if (snapshot.data!.isEmpty) {
                      return Container();
                    }
                    final row37QuizQuestionsRecord =
                        row37QuizQuestionsRecordList.isNotEmpty
                            ? row37QuizQuestionsRecordList.first
                            : null;

                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 12.0, 16.0, 8.0),
                            child: Container(
                              width: 100.0,
                              decoration: BoxDecoration(
                                color: FFAppState()
                                            .selectedOptionsForty
                                            .elementAtOrNull(36) ==
                                        row37QuizQuestionsRecord
                                            ?.correctAnswerLetter
                                    ? FlutterFlowTheme.of(context)
                                        .correctWithOpacity
                                    : FlutterFlowTheme.of(context)
                                        .wrongAnswerBackground,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15.0),
                                  bottomRight: Radius.circular(15.0),
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                                border: Border.all(
                                  color: FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(36) ==
                                          row37QuizQuestionsRecord
                                              ?.correctAnswerLetter
                                      ? FlutterFlowTheme.of(context).tertiary
                                      : FlutterFlowTheme.of(context)
                                          .wrongAnswerBorder,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      () {
                                        if (row37QuizQuestionsRecord
                                                ?.correctAnswerLetter ==
                                            FFAppState()
                                                .selectedOptionsForty
                                                .elementAtOrNull(36)) {
                                          return 'Poprawna odpowiedź';
                                        } else if (FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(36) ==
                                                null ||
                                            FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(36) ==
                                                '') {
                                          return 'Brak odpowiedzi';
                                        } else {
                                          return 'Błędna odpowiedź';
                                        }
                                      }(),
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      'Treść pytania: ${row37QuizQuestionsRecord?.description}',
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  if (row37QuizQuestionsRecord?.questionPhoto !=
                                          null &&
                                      row37QuizQuestionsRecord?.questionPhoto !=
                                          '')
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
                                              child:
                                                  FlutterFlowExpandedImageView(
                                                image: Image.network(
                                                  row37QuizQuestionsRecord
                                                      .questionPhoto,
                                                  fit: BoxFit.contain,
                                                ),
                                                allowRotation: false,
                                                tag: row37QuizQuestionsRecord
                                                    .questionPhoto,
                                                useHeroAnimation: true,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Hero(
                                          tag: row37QuizQuestionsRecord!
                                              .questionPhoto,
                                          transitionOnUserGestures: true,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              row37QuizQuestionsRecord
                                                  .questionPhoto,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if ((FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(36) !=
                                          row37QuizQuestionsRecord
                                              ?.correctAnswerLetter) &&
                                      (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(36) !=
                                              null &&
                                          FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(36) !=
                                              ''))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Twoja odpowiedź: ${FFAppState().selectedOptionsForty.elementAtOrNull(36)}. ${row37QuizQuestionsRecord?.options.elementAtOrNull(() {
                                          if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(36) ==
                                              'A') {
                                            return 0;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(36) ==
                                              'B') {
                                            return 1;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(36) ==
                                              'C') {
                                            return 2;
                                          } else {
                                            return 3;
                                          }
                                        }())}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if (FFAppState()
                                          .selectedOptionsForty
                                          .elementAtOrNull(36) !=
                                      row37QuizQuestionsRecord
                                          ?.correctAnswerLetter)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Poprawna odpowiedź: ${row37QuizQuestionsRecord?.correctAnswerLetter}. ${row37QuizQuestionsRecord?.correctAnswer}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if ((valueOrDefault<bool>(
                                              currentUserDocument
                                                  ?.isUserPremium,
                                              false) ==
                                          true) ||
                                      ((valueOrDefault<bool>(
                                                  currentUserDocument
                                                      ?.isUserPremium,
                                                  false) ==
                                              false) &&
                                          (_model.adWatched == true)))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 12.0),
                                      child: AuthUserStreamWidget(
                                        builder: (context) => Text(
                                          'Wyjaśnienie: ${row37QuizQuestionsRecord?.explenation}',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.manrope(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
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
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                StreamBuilder<List<QuizQuestionsRecord>>(
                  stream: queryQuizQuestionsRecord(
                    queryBuilder: (quizQuestionsRecord) =>
                        quizQuestionsRecord.where(
                      'question_id',
                      isEqualTo:
                          FFAppState().listOfQuestionsID.elementAtOrNull(37),
                    ),
                    singleRecord: true,
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: SpinKitFoldingCube(
                            color: FlutterFlowTheme.of(context).primary,
                            size: 50.0,
                          ),
                        ),
                      );
                    }
                    List<QuizQuestionsRecord> row38QuizQuestionsRecordList =
                        snapshot.data!;
                    // Return an empty Container when the item does not exist.
                    if (snapshot.data!.isEmpty) {
                      return Container();
                    }
                    final row38QuizQuestionsRecord =
                        row38QuizQuestionsRecordList.isNotEmpty
                            ? row38QuizQuestionsRecordList.first
                            : null;

                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 12.0, 16.0, 8.0),
                            child: Container(
                              width: 100.0,
                              decoration: BoxDecoration(
                                color: FFAppState()
                                            .selectedOptionsForty
                                            .elementAtOrNull(37) ==
                                        row38QuizQuestionsRecord
                                            ?.correctAnswerLetter
                                    ? FlutterFlowTheme.of(context)
                                        .correctWithOpacity
                                    : FlutterFlowTheme.of(context)
                                        .wrongAnswerBackground,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15.0),
                                  bottomRight: Radius.circular(15.0),
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                                border: Border.all(
                                  color: FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(37) ==
                                          row38QuizQuestionsRecord
                                              ?.correctAnswerLetter
                                      ? FlutterFlowTheme.of(context).tertiary
                                      : FlutterFlowTheme.of(context)
                                          .wrongAnswerBorder,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      () {
                                        if (row38QuizQuestionsRecord
                                                ?.correctAnswerLetter ==
                                            FFAppState()
                                                .selectedOptionsForty
                                                .elementAtOrNull(37)) {
                                          return 'Poprawna odpowiedź';
                                        } else if (FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(37) ==
                                                null ||
                                            FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(37) ==
                                                '') {
                                          return 'Brak odpowiedzi';
                                        } else {
                                          return 'Błędna odpowiedź';
                                        }
                                      }(),
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      'Treść pytania: ${row38QuizQuestionsRecord?.description}',
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  if (row38QuizQuestionsRecord?.questionPhoto !=
                                          null &&
                                      row38QuizQuestionsRecord?.questionPhoto !=
                                          '')
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
                                              child:
                                                  FlutterFlowExpandedImageView(
                                                image: Image.network(
                                                  row38QuizQuestionsRecord
                                                      .questionPhoto,
                                                  fit: BoxFit.contain,
                                                ),
                                                allowRotation: false,
                                                tag: row38QuizQuestionsRecord
                                                    .questionPhoto,
                                                useHeroAnimation: true,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Hero(
                                          tag: row38QuizQuestionsRecord!
                                              .questionPhoto,
                                          transitionOnUserGestures: true,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              row38QuizQuestionsRecord
                                                  .questionPhoto,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if ((FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(37) !=
                                          row38QuizQuestionsRecord
                                              ?.correctAnswerLetter) &&
                                      (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(37) !=
                                              null &&
                                          FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(37) !=
                                              ''))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Twoja odpowiedź: ${FFAppState().selectedOptionsForty.elementAtOrNull(37)}. ${row38QuizQuestionsRecord?.options.elementAtOrNull(() {
                                          if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(37) ==
                                              'A') {
                                            return 0;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(37) ==
                                              'B') {
                                            return 1;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(37) ==
                                              'C') {
                                            return 2;
                                          } else {
                                            return 3;
                                          }
                                        }())}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if (FFAppState()
                                          .selectedOptionsForty
                                          .elementAtOrNull(37) !=
                                      row38QuizQuestionsRecord
                                          ?.correctAnswerLetter)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Poprawna odpowiedź: ${row38QuizQuestionsRecord?.correctAnswerLetter}. ${row38QuizQuestionsRecord?.correctAnswer}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if ((valueOrDefault<bool>(
                                              currentUserDocument
                                                  ?.isUserPremium,
                                              false) ==
                                          true) ||
                                      ((valueOrDefault<bool>(
                                                  currentUserDocument
                                                      ?.isUserPremium,
                                                  false) ==
                                              false) &&
                                          (_model.adWatched == true)))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 12.0),
                                      child: AuthUserStreamWidget(
                                        builder: (context) => Text(
                                          'Wyjaśnienie: ${row38QuizQuestionsRecord?.explenation}',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.manrope(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
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
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                StreamBuilder<List<QuizQuestionsRecord>>(
                  stream: queryQuizQuestionsRecord(
                    queryBuilder: (quizQuestionsRecord) =>
                        quizQuestionsRecord.where(
                      'question_id',
                      isEqualTo:
                          FFAppState().listOfQuestionsID.elementAtOrNull(38),
                    ),
                    singleRecord: true,
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: SpinKitFoldingCube(
                            color: FlutterFlowTheme.of(context).primary,
                            size: 50.0,
                          ),
                        ),
                      );
                    }
                    List<QuizQuestionsRecord> row39QuizQuestionsRecordList =
                        snapshot.data!;
                    // Return an empty Container when the item does not exist.
                    if (snapshot.data!.isEmpty) {
                      return Container();
                    }
                    final row39QuizQuestionsRecord =
                        row39QuizQuestionsRecordList.isNotEmpty
                            ? row39QuizQuestionsRecordList.first
                            : null;

                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 12.0, 16.0, 8.0),
                            child: Container(
                              width: 100.0,
                              decoration: BoxDecoration(
                                color: FFAppState()
                                            .selectedOptionsForty
                                            .elementAtOrNull(38) ==
                                        row39QuizQuestionsRecord
                                            ?.correctAnswerLetter
                                    ? FlutterFlowTheme.of(context)
                                        .correctWithOpacity
                                    : FlutterFlowTheme.of(context)
                                        .wrongAnswerBackground,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15.0),
                                  bottomRight: Radius.circular(15.0),
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                                border: Border.all(
                                  color: FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(38) ==
                                          row39QuizQuestionsRecord
                                              ?.correctAnswerLetter
                                      ? FlutterFlowTheme.of(context).tertiary
                                      : FlutterFlowTheme.of(context)
                                          .wrongAnswerBorder,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      () {
                                        if (row39QuizQuestionsRecord
                                                ?.correctAnswerLetter ==
                                            FFAppState()
                                                .selectedOptionsForty
                                                .elementAtOrNull(38)) {
                                          return 'Poprawna odpowiedź';
                                        } else if (FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(38) ==
                                                null ||
                                            FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(38) ==
                                                '') {
                                          return 'Brak odpowiedzi';
                                        } else {
                                          return 'Błędna odpowiedź';
                                        }
                                      }(),
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      'Treść pytania: ${row39QuizQuestionsRecord?.description}',
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  if (row39QuizQuestionsRecord?.questionPhoto !=
                                          null &&
                                      row39QuizQuestionsRecord?.questionPhoto !=
                                          '')
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
                                              child:
                                                  FlutterFlowExpandedImageView(
                                                image: Image.network(
                                                  row39QuizQuestionsRecord
                                                      .questionPhoto,
                                                  fit: BoxFit.contain,
                                                ),
                                                allowRotation: false,
                                                tag: row39QuizQuestionsRecord
                                                    .questionPhoto,
                                                useHeroAnimation: true,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Hero(
                                          tag: row39QuizQuestionsRecord!
                                              .questionPhoto,
                                          transitionOnUserGestures: true,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              row39QuizQuestionsRecord
                                                  .questionPhoto,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if ((FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(38) !=
                                          row39QuizQuestionsRecord
                                              ?.correctAnswerLetter) &&
                                      (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(38) !=
                                              null &&
                                          FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(38) !=
                                              ''))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Twoja odpowiedź: ${FFAppState().selectedOptionsForty.elementAtOrNull(38)}. ${row39QuizQuestionsRecord?.options.elementAtOrNull(() {
                                          if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(38) ==
                                              'A') {
                                            return 0;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(38) ==
                                              'B') {
                                            return 1;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(38) ==
                                              'C') {
                                            return 2;
                                          } else {
                                            return 3;
                                          }
                                        }())}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if (FFAppState()
                                          .selectedOptionsForty
                                          .elementAtOrNull(38) !=
                                      row39QuizQuestionsRecord
                                          ?.correctAnswerLetter)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Poprawna odpowiedź: ${row39QuizQuestionsRecord?.correctAnswerLetter}. ${row39QuizQuestionsRecord?.correctAnswer}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if ((valueOrDefault<bool>(
                                              currentUserDocument
                                                  ?.isUserPremium,
                                              false) ==
                                          true) ||
                                      ((valueOrDefault<bool>(
                                                  currentUserDocument
                                                      ?.isUserPremium,
                                                  false) ==
                                              false) &&
                                          (_model.adWatched == true)))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 12.0),
                                      child: AuthUserStreamWidget(
                                        builder: (context) => Text(
                                          'Wyjaśnienie: ${row39QuizQuestionsRecord?.explenation}',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.manrope(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
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
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                StreamBuilder<List<QuizQuestionsRecord>>(
                  stream: queryQuizQuestionsRecord(
                    queryBuilder: (quizQuestionsRecord) =>
                        quizQuestionsRecord.where(
                      'question_id',
                      isEqualTo:
                          FFAppState().listOfQuestionsID.elementAtOrNull(39),
                    ),
                    singleRecord: true,
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: SpinKitFoldingCube(
                            color: FlutterFlowTheme.of(context).primary,
                            size: 50.0,
                          ),
                        ),
                      );
                    }
                    List<QuizQuestionsRecord> row40QuizQuestionsRecordList =
                        snapshot.data!;
                    // Return an empty Container when the item does not exist.
                    if (snapshot.data!.isEmpty) {
                      return Container();
                    }
                    final row40QuizQuestionsRecord =
                        row40QuizQuestionsRecordList.isNotEmpty
                            ? row40QuizQuestionsRecordList.first
                            : null;

                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 12.0, 16.0, 8.0),
                            child: Container(
                              width: 100.0,
                              decoration: BoxDecoration(
                                color: FFAppState()
                                            .selectedOptionsForty
                                            .elementAtOrNull(39) ==
                                        row40QuizQuestionsRecord
                                            ?.correctAnswerLetter
                                    ? FlutterFlowTheme.of(context)
                                        .correctWithOpacity
                                    : FlutterFlowTheme.of(context)
                                        .wrongAnswerBackground,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15.0),
                                  bottomRight: Radius.circular(15.0),
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                                border: Border.all(
                                  color: FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(39) ==
                                          row40QuizQuestionsRecord
                                              ?.correctAnswerLetter
                                      ? FlutterFlowTheme.of(context).tertiary
                                      : FlutterFlowTheme.of(context)
                                          .wrongAnswerBorder,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      () {
                                        if (row40QuizQuestionsRecord
                                                ?.correctAnswerLetter ==
                                            FFAppState()
                                                .selectedOptionsForty
                                                .elementAtOrNull(39)) {
                                          return 'Poprawna odpowiedź';
                                        } else if (FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(39) ==
                                                null ||
                                            FFAppState()
                                                    .selectedOptionsForty
                                                    .elementAtOrNull(39) ==
                                                '') {
                                          return 'Brak odpowiedzi';
                                        } else {
                                          return 'Błędna odpowiedź';
                                        }
                                      }(),
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      'Treść pytania: ${row40QuizQuestionsRecord?.description}',
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  if (row40QuizQuestionsRecord?.questionPhoto !=
                                          null &&
                                      row40QuizQuestionsRecord?.questionPhoto !=
                                          '')
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
                                              child:
                                                  FlutterFlowExpandedImageView(
                                                image: Image.network(
                                                  row40QuizQuestionsRecord
                                                      .questionPhoto,
                                                  fit: BoxFit.contain,
                                                ),
                                                allowRotation: false,
                                                tag: row40QuizQuestionsRecord
                                                    .questionPhoto,
                                                useHeroAnimation: true,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Hero(
                                          tag: row40QuizQuestionsRecord!
                                              .questionPhoto,
                                          transitionOnUserGestures: true,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              row40QuizQuestionsRecord
                                                  .questionPhoto,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if ((FFAppState()
                                              .selectedOptionsForty
                                              .elementAtOrNull(39) !=
                                          row40QuizQuestionsRecord
                                              ?.correctAnswerLetter) &&
                                      (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(39) !=
                                              null &&
                                          FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(39) !=
                                              ''))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Twoja odpowiedź: ${FFAppState().selectedOptionsForty.elementAtOrNull(39)}. ${row40QuizQuestionsRecord?.options.elementAtOrNull(() {
                                          if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(39) ==
                                              'A') {
                                            return 0;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(39) ==
                                              'B') {
                                            return 1;
                                          } else if (FFAppState()
                                                  .selectedOptionsForty
                                                  .elementAtOrNull(39) ==
                                              'C') {
                                            return 2;
                                          } else {
                                            return 3;
                                          }
                                        }())}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if (FFAppState()
                                          .selectedOptionsForty
                                          .elementAtOrNull(39) !=
                                      row40QuizQuestionsRecord
                                          ?.correctAnswerLetter)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 6.0),
                                      child: Text(
                                        'Poprawna odpowiedź: ${row40QuizQuestionsRecord?.correctAnswerLetter}. ${row40QuizQuestionsRecord?.correctAnswer}',
                                        style: FlutterFlowTheme.of(context)
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
                                      ),
                                    ),
                                  if ((valueOrDefault<bool>(
                                              currentUserDocument
                                                  ?.isUserPremium,
                                              false) ==
                                          true) ||
                                      ((valueOrDefault<bool>(
                                                  currentUserDocument
                                                      ?.isUserPremium,
                                                  false) ==
                                              false) &&
                                          (_model.adWatched == true)))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 6.0, 12.0, 12.0),
                                      child: AuthUserStreamWidget(
                                        builder: (context) => Text(
                                          'Wyjaśnienie: ${row40QuizQuestionsRecord?.explenation}',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.manrope(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
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
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
