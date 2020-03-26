import '../homeView/homeViewModel.dart';

class PolicyQuestionItem {
  String question = "";
  String ans = "";

  PolicyQuestionItem({this.question = "", this.ans = ""});
}

class PolicyViewModel {
  final String message = "Prompt, accurate time tracking is fundamental to the "
      "health of our business. Publicis.Sapient expects each person to log their "
      "actual time worked to the correct Project IDs (PIDs) on a weekly basis. ";

  List<BulletPointItem> bulletPoints = [
    BulletPointItem(title: "When filling out your time card, please remember...", isBullet: false),
    BulletPointItem(title: "Record your actual hours! It is important to work the hours you are allocated at a minimum. ", isBullet: true),
    BulletPointItem(title: "If there is a material change on your project and the allocation will not be realized, be sure you are working with your project team to fill in the time. If you end up with materially more availability than planned, please be sure to notify your staffing partner right away. ", isBullet: true),
    BulletPointItem(title: "Asking someone, or being asked, to charge time other than what was actually worked is an ethics violation.", isBullet: true),
    BulletPointItem(title: "Under-billing or padding billable hours is not allowed, for any reason.", isBullet: true),
    BulletPointItem(title: "Altering time cards to meet profit and loss expectations is not allowed, for any reason.", isBullet: true),
    BulletPointItem(title: "Using alternate PIDs is not allowed. This means logging your time to the correct Bench or project-related PID and leveraging the drop-down menu as needed to designate the way your time is spent.", isBullet: true),
    BulletPointItem(title: "\nRead more below to understand what specifically is expected of you when submitting and approving time cards each week.", isBullet: false),
  ];

  double bulletRowHeight = 70.0;
  double get bulletTileHeight {
    //adding 20 for space above the last bullet point
    return (bulletPoints.length * bulletRowHeight) + 20.0;
  }

  //Questions Data
  static String ans1 = "Publicis.Sapient is in the business of delivering value to our clients. In the case of contracted time and materials work, we generate revenue based on the value we provide by quantifying our people's time and charging our clients for that time."
      "<p>Failure to adhere to this policy, whether related to client work (Time and Materials or Fixed-Time/Fixed-Price) or internal work (Marketing, Finance, or People Team work) will adversely impact:"
      "</p>"
      "<p>  • accuracy and timeliness of billings</p>"
      "<p>  • monthly and quarter closes</p>"
      "<p>  • business performance assessments</p>"
      "<p>  • DSO (Days Sales Outstanding) calculations</p>"
      "<p><br>It is incumbent upon each of us to do our part to ensure that we are operating as efficiently and effectively as possible.</p>"
      "</p>";

  static String ans2 = "This policy applies to all full-time and part-time Publicis.Sapient people and any independent contractors."
      "<p><b>Sapient Consulting | Public Sector</b></p>"
      "<p>While Public Sector has its own tool (Deltek Time and Expense) and must follow federally-regulated requirements for time tracking, Publicis.Sapient people are still bound by the P.S policy. Our policy is a \"baseline\" policy for Public Sector that is supplemented by the Public Sector-specific procedures such as the use of Deltek, daily inputs of time, daily floor checks and more stringent approval dates.</p>"
      "<p><br><b>Contractor Time Tracking</b></p>"
      "<p>Contractors must also submit a time card each week. The P.S person who is managing the Contractor must make sure that the Contractor both understands this requirement and knows how to comply. Contractors are not allowed to use a bench PID or enter hours for company holiday or personal vacation."
      "</p>";

  static String ans3 = "You must personally submit all your own time cards. If it is not possible for you to submit your time card, please log a Help Desk ticket under \"People Success\" for support."
      "<p><b>Deadlines</b></p>"
      "<p>All time cards need to be submitted by the following deadlines or they will be in violation of this policy. Deadlines shift one hour earlier in these time zones during U.S. Daylight Saving Time for the previous week (ending Sunday).</p>"
      "<p>  • North America - Eastern (ET)  :  Monday 3pm</p>"
      "<p>  • North America - Pacific (PT)  :  Monday 12pm (noon)</p>"
      "<p>  • United Kingdom (GMT)  :  Monday 8pm</p>"
      "<p>  • India (IST)  :  	Tuesday 1:30am</p>"
      "<p><br><b>Notifications</b></p>"
      "<p>You will receive automatic email alerts from the Time Tracking mailbox to remind you to submit your time card each week. You will also receive an email notification if you do not submit your time card by the above deadline."
      "</p>"
      "<p><br><b>Rejected Timecards</b></p>"
      "<p>If your time card is rejected by the approver, it will be returned to you for re-submission or submission of a new card for that time period. For each rejection, the clock for resubmission restarts based on the date of rejection and you will have 24 hours to resubmit to be considered timely."
      "</p>";

  static String ans4 = "You should ensure that you are staffed to the applicable Project ID (PID) before submitting any number of billable hours on a Time and Materials (T&M) project and eight or more hours on a Fixed Time/Fixed Price (FT/FP) or long term support project."
      "<p>When you are asked to perform work, confirm with the requestor that the PID is \"time tracking ready\". This means that the PID is 95% or higher in probability and has been \"approved\" in Oracle.</p>"
      "<p>These staffing and PID requirements do not apply to any non-billable time, internal projects, small services, or media spend projects."
      "</p>";

  static String ans5 = "When planning vacation or a leave of absence (LOA), there may be periods during which you are required to track your time. During a leave of absence (LOA) status, you cannot fill a time card; however, if you are using vacation time to supplement time off, a timecard is required. Please note:"
      "<p>When you are asked to perform work, confirm with the requestor that the PID is \"time tracking ready\". This means that the PID is 95% or higher in probability and has been \"approved\" in Oracle.</p>"
      "<p>  • If you are a delivery person taking vacation, use the bench PID and choose 'vacation' as type from the drop down. </p>"
      "<p>  • If you are a non-delivery person taking vacation, use your 'home' PID and choose 'vacation' as type from the drop down.</p>";

  static String ans6 = "If you are aware of, or suspect, any time card violations as stated above, you may use any of the following avenues to report the violation(s):"
      "<p>  • Ethics Hotline – use this avenue to report violations anonymously</p>"
      "<p>  • Your People Strategist or HR Business Partner</p>"
      "<p>  • Trusted Mentor</p>"
      "<p>  • Project Leader/Executive/Sponsor</p>"
      "<p>  • Staffing coordinator</p>"
      "<p><br>Each of these individuals/teams are equipped to help you determine if a violation has indeed occurred and what steps need to be taken to resolve the situation.</p>"
      "<p><br>Publicis.Sapient takes this policy very seriously and will strictly enforce it.  Any reported incidents of violation will be looked into and dealt with appropriately.</p>";


  List<PolicyQuestionItem> questions = [
    PolicyQuestionItem(question: "Why Publicis.Sapient Has A Time Tracking Policy?", ans: ans1),
    PolicyQuestionItem(question: "Who Is Expected To Follow The Time Tracking Policy?", ans: ans2),
    PolicyQuestionItem(question: "Submission Deadlines", ans: ans3),
    PolicyQuestionItem(question: "PID Allocation", ans: ans4),
    PolicyQuestionItem(question: "Vacation And Leave", ans: ans5),
    PolicyQuestionItem(question: "Reporting Violations", ans: ans6),
  ];

}