import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'new_cart_view_model.dart';
export 'new_cart_view_model.dart';

class NewCartViewWidget extends StatefulWidget {
  const NewCartViewWidget({super.key});

  @override
  State<NewCartViewWidget> createState() => _NewCartViewWidgetState();
}

class _NewCartViewWidgetState extends State<NewCartViewWidget> {
  late NewCartViewModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NewCartViewModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
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
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            context.pushNamed('Checkout');
          },
          backgroundColor: FlutterFlowTheme.of(context).tertiary,
          elevation: 8.0,
          label: Text(
            'Checkout Total :${FFAppState().totalPrice.toString()}',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Readex Pro',
                  color: FlutterFlowTheme.of(context).primaryBackground,
                  letterSpacing: 0.0,
                ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Color(0xFFEA7724),
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () async {
              context.pushNamed('HomePage');
            },
          ),
          title: Text(
            'Shopping Cart',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Outfit',
                  color: Colors.white,
                  fontSize: 22.0,
                  letterSpacing: 0.0,
                ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  StreamBuilder<List<CartRecord>>(
                    stream: queryCartRecord(
                      queryBuilder: (cartRecord) => cartRecord.where(
                        'user_ref',
                        isEqualTo: currentUserReference,
                      ),
                    ),
                    builder: (context, snapshot) {
                      // Customize what your widget looks like when it's loading.
                      if (!snapshot.hasData) {
                        return Center(
                          child: SizedBox(
                            width: 50.0,
                            height: 50.0,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                FlutterFlowTheme.of(context).primary,
                              ),
                            ),
                          ),
                        );
                      }
                      List<CartRecord> columnCartRecordList = snapshot.data!;
                      return SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: List.generate(columnCartRecordList.length,
                              (columnIndex) {
                            final columnCartRecord =
                                columnCartRecordList[columnIndex];
                            return Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              elevation: 4.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 35.0, 0.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.network(
                                            columnCartRecord.image,
                                            width: 100.0,
                                            height: 101.0,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              columnCartRecord.name,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        letterSpacing: 0.0,
                                                      ),
                                            ),
                                            Text(
                                              formatNumber(
                                                columnCartRecord.finalPrice,
                                                formatType: FormatType.custom,
                                                format: '₹',
                                                locale: '',
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        letterSpacing: 0.0,
                                                      ),
                                            ),
                                          ],
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: FFButtonWidget(
                                            onPressed: () async {
                                              setState(() {
                                                FFAppState().totalPrice =
                                                    FFAppState().totalPrice +
                                                        functions.negativePrice(
                                                            columnCartRecord
                                                                .price,
                                                            columnCartRecord
                                                                .quantity);
                                              });
                                              await columnCartRecord.reference
                                                  .delete();
                                            },
                                            text: 'Remove',
                                            options: FFButtonOptions(
                                              height: 40.0,
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      24.0, 0.0, 24.0, 0.0),
                                              iconPadding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              color: Color(0xFFD4132C),
                                              textStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        color: Colors.white,
                                                        letterSpacing: 0.0,
                                                      ),
                                              elevation: 3.0,
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(1.0, 0.0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 10.0),
                                      child: Wrap(
                                        spacing: 10.0,
                                        runSpacing: 0.0,
                                        alignment: WrapAlignment.start,
                                        crossAxisAlignment:
                                            WrapCrossAlignment.start,
                                        direction: Axis.horizontal,
                                        runAlignment: WrapAlignment.start,
                                        verticalDirection:
                                            VerticalDirection.down,
                                        clipBehavior: Clip.none,
                                        children: [
                                          FlutterFlowIconButton(
                                            borderColor: Color(0xFFD4132C),
                                            borderRadius: 10.0,
                                            borderWidth: 1.0,
                                            buttonSize: 40.0,
                                            fillColor: Color(0xFFD4132C),
                                            icon: Icon(
                                              Icons.remove_sharp,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                              size: 24.0,
                                            ),
                                            onPressed: (columnCartRecord
                                                        .quantity ==
                                                    1)
                                                ? null
                                                : () async {
                                                    await columnCartRecord
                                                        .reference
                                                        .update({
                                                      ...mapToFirestore(
                                                        {
                                                          'final_price':
                                                              FieldValue.increment(
                                                                  -(columnCartRecord
                                                                      .price)),
                                                          'quantity': FieldValue
                                                              .increment(-(1)),
                                                        },
                                                      ),
                                                    });
                                                    _model.deleteQuery =
                                                        await queryCartRecordOnce(
                                                      queryBuilder:
                                                          (cartRecord) =>
                                                              cartRecord.where(
                                                        'user_ref',
                                                        isEqualTo:
                                                            currentUserReference,
                                                      ),
                                                    );
                                                    setState(() {
                                                      FFAppState().totalPrice =
                                                          functions.listsum(_model
                                                              .deleteQuery!
                                                              .map((e) =>
                                                                  e.finalPrice)
                                                              .toList()
                                                              .sortedList((e) =>
                                                                  e.toString())
                                                              .toList());
                                                    });

                                                    setState(() {});
                                                  },
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 10.0, 0.0, 0.0),
                                            child: Text(
                                              columnCartRecord.quantity
                                                  .toString(),
                                              textAlign: TextAlign.center,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        letterSpacing: 0.0,
                                                      ),
                                            ),
                                          ),
                                          FlutterFlowIconButton(
                                            borderColor:
                                                FlutterFlowTheme.of(context)
                                                    .success,
                                            borderRadius: 10.0,
                                            borderWidth: 1.0,
                                            buttonSize: 40.0,
                                            fillColor:
                                                FlutterFlowTheme.of(context)
                                                    .success,
                                            icon: Icon(
                                              Icons.add,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                              size: 24.0,
                                            ),
                                            onPressed: () async {
                                              await columnCartRecord.reference
                                                  .update({
                                                ...mapToFirestore(
                                                  {
                                                    'final_price':
                                                        FieldValue.increment(
                                                            columnCartRecord
                                                                .price),
                                                    'quantity':
                                                        FieldValue.increment(1),
                                                  },
                                                ),
                                              });
                                              _model.updateQuery =
                                                  await queryCartRecordOnce(
                                                queryBuilder: (cartRecord) =>
                                                    cartRecord.where(
                                                  'user_ref',
                                                  isEqualTo:
                                                      currentUserReference,
                                                ),
                                              );
                                              setState(() {
                                                FFAppState().totalPrice =
                                                    functions.listsum(_model
                                                        .updateQuery!
                                                        .map(
                                                            (e) => e.finalPrice)
                                                        .toList()
                                                        .sortedList(
                                                            (e) => e.toString())
                                                        .toList());
                                              });

                                              setState(() {});
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
