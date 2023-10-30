// import 'package:flutter/material.dart';
// import 'package:school_manager_project/app/constants/style.dart';
// import 'package:school_manager_project/app/pages/chart/bar_charts/custom_rounded_bars/custom_rounded_bars_bar_chart.dart';
// import 'package:school_manager_project/app/pages/chart/bar_charts/grouped/grouped_bar_chart.dart';
// import 'package:school_manager_project/app/pages/chart/bar_charts/grouped_fill_color/grouped_fill_color_bar_chart.dart';
// import 'package:school_manager_project/app/pages/chart/bar_charts/horizontal_bar_label/horizontal_bar_label_bar_chart.dart';
// import 'package:school_manager_project/app/pages/chart/bar_charts/horizontal_pattern_forward_hatch/horizontal_pattern_forward_hatch_bar_chart.dart';
// import 'package:school_manager_project/app/pages/chart/bar_charts/stacked_horizontal.dart/stacked_horizontal_bar_chart.dart';
// import 'package:school_manager_project/app/pages/chart/bar_charts/vertical_bar_label/vertical_bar_label_bar_chart.dart';
// import 'package:school_manager_project/app/pages/chart/pie_charts/simple_pie_chart.dart';
// import 'package:school_manager_project/app/pages/chart/scatter_plot_charts/bucketing_axis.dart';
// import 'package:school_manager_project/app/pages/chart/scatter_plot_charts/ordinal_bar_line.dart';
// import 'package:school_manager_project/app/pages/chart/scatter_plot_charts/scatter_plot_line.dart';
// import 'package:school_manager_project/app/pages/chart/time_series_charts/legend_with_measures_legends.dart';
// import 'package:school_manager_project/app/pages/chart/time_series_charts/range_annotation_margin.dart';
// import 'package:school_manager_project/app/pages/chart/time_series_charts/symbol_annotation_time_series_chart.dart';
// import 'package:school_manager_project/app/pages/chart/time_series_charts/with_bar_renderer.dart';
// import 'package:school_manager_project/app/pages/overview/widgets/bar_chart.dart';
// import 'package:school_manager_project/app/widgets/custom_text.dart';

// class ChartScreen extends StatelessWidget {
//   const ChartScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         title: const Expanded(
//           child: CustomText(
//             text: 'Biểu đồ',
//             weight: FontWeight.bold,
//           ),
//         ),
//         iconTheme: const IconThemeData(color: Colors.black),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(12),
//               margin: const EdgeInsets.symmetric(vertical: 30),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(8),
//                 boxShadow: [BoxShadow(offset: const Offset(0, 6), color: lightGrey.withOpacity(.1), blurRadius: 12)],
//                 border: Border.all(color: lightGrey, width: .5),
//               ),
//               child: Column(
//                 children: [
//                   Container(
//                     alignment: Alignment.topLeft,
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     child: const CustomText(
//                       text: "Bar Charts",
//                       size: 20,
//                       weight: FontWeight.bold,
//                       color: lightGrey,
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       Expanded(child: SizedBox(width: 600, height: 200, child: SimpleBarChart.withSampleData())),
//                       Expanded(child: SizedBox(width: 600, height: 200, child: GroupedBarChart.withSampleData())),
//                     ],
//                   ),
//                   const SizedBox(height: 30),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: SizedBox(
//                           width: 600,
//                           height: 200,
//                           child: StackedHorizontalBarChart.withSampleData(),
//                         ),
//                       ),
//                       Expanded(
//                         child: SizedBox(
//                           width: 600,
//                           height: 200,
//                           child: HorizontalBarLabelChart.withSampleData(),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 30),
//                   Row(
//                     children: [
//                       Expanded(child: SizedBox(width: 600, height: 200, child: VerticalBarLabelChart.withSampleData())),
//                       Expanded(
//                         child: SizedBox(
//                           width: 600,
//                           height: 200,
//                           child: GroupedFillColorBarChart.withSampleData(),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 30),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: SizedBox(
//                           width: 600,
//                           height: 200,
//                           child: HorizontalPatternForwardHatchBarChart.withSampleData(),
//                         ),
//                       ),
//                       Expanded(child: SizedBox(width: 600, height: 200, child: CustomRoundedBars.withSampleData())),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.all(12),
//               margin: const EdgeInsets.symmetric(vertical: 30),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(8),
//                 boxShadow: [BoxShadow(offset: const Offset(0, 6), color: lightGrey.withOpacity(.1), blurRadius: 12)],
//                 border: Border.all(color: lightGrey, width: .5),
//               ),
//               child: Column(
//                 children: [
//                   Container(
//                     alignment: Alignment.topLeft,
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     child: const CustomText(
//                       text: "Line Charts",
//                       size: 20,
//                       weight: FontWeight.bold,
//                       color: lightGrey,
//                     ),
//                   ),
//                   SizedBox(width: 1000, height: 200, child: LineRangeAnnotationMarginChart.withSampleData()),
//                   const SizedBox(height: 30),
//                   SizedBox(width: 1000, height: 200, child: TimeSeriesSymbolAnnotationChart.withSampleData()),
//                   const SizedBox(height: 30),
//                   SizedBox(width: 1000, height: 200, child: TimeSeriesBar.withSampleData()),
//                   const SizedBox(height: 30),
//                   SizedBox(width: 1000, height: 200, child: OrdinalComboBarLineChart.withSampleData()),
//                   const SizedBox(height: 30),
//                   SizedBox(width: 1000, height: 200, child: LegendWithMeasures.withSampleData()),
//                 ],
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.all(12),
//               margin: const EdgeInsets.symmetric(vertical: 30),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(8),
//                 boxShadow: [BoxShadow(offset: const Offset(0, 6), color: lightGrey.withOpacity(.1), blurRadius: 12)],
//                 border: Border.all(color: lightGrey, width: .5),
//               ),
//               child: Column(
//                 children: [
//                   Container(
//                     alignment: Alignment.topLeft,
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     child: const CustomText(
//                       text: "Scatter Plot Charts",
//                       size: 20,
//                       weight: FontWeight.bold,
//                       color: lightGrey,
//                     ),
//                   ),
//                   SizedBox(width: 1000, height: 200, child: BucketingAxisScatterPlotChart.withSampleData()),
//                   const SizedBox(height: 30),
//                   SizedBox(width: 1000, height: 200, child: ScatterPlotComboLineChart.withSampleData()),
//                 ],
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.all(12),
//               margin: const EdgeInsets.symmetric(vertical: 30),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(8),
//                 boxShadow: [BoxShadow(offset: const Offset(0, 6), color: lightGrey.withOpacity(.1), blurRadius: 12)],
//                 border: Border.all(color: lightGrey, width: .5),
//               ),
//               child: Column(
//                 children: [
//                   Container(
//                     alignment: Alignment.topLeft,
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     child: const CustomText(
//                       text: "Pie Charts",
//                       size: 20,
//                       weight: FontWeight.bold,
//                       color: lightGrey,
//                     ),
//                   ),
//                   SizedBox(width: 600, height: 600, child: SimplePieChart.withSampleData()),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
