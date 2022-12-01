const sgMail = require("@sendgrid/mail");

const sendGridAPI =
  "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";

sgMail.setApiKey(sendGridAPI);

// sgMail.send({
//   to: "sa.hamzeh@hotmail.com",
//   from: "kahrabai.company@gmail.com",
//   subject: "welocme hamzeh",
//   text: "this is an email to hamzeh",
// });

const sendWelcomeEmail = (email, name) => {
  sgMail.send({
    to: email,
    from: "kahrabai.company@gmail.com",
    subject: "اعادة تعيين كلمة المرور",
    text: `عزيزي/تي المواطن/ة  ${name}, بناء على طلبك لاعادة تعيين كلمة المرور قم باستخدام الرمز التالي 4325`,
  });
};

const sendCancelationEmail = (email, name) => {
  sgMail.send({
    to: email,
    from: "kahrabai.company@gmail.com",
    subject: "حذف الحساب الخاص بك",
    text: ` عزيزي/تي المواطن/ة  ${name} , بناء على مخالفتك قوانين استخدام التطبيق و استخدامه بشكل خاطئ فاننا يؤسفنا حذف حسابك وذلك حرصا على عملية سير التطبيق. `,
  });
};

const ForgetPassEmail = (email, name, Verify) => {
  sgMail.send({
    to: email,
    from: "kahrabai.company@gmail.com",
    subject: "اعادة تعيين كلمة المرور",
    text: `عزيزي/تي المواطن/ة  ${name} , بناء على طلبك لاعادة تعيين كلمة المرور قم باستخدام كلمة المرور التالية لتسجيل الدخول الى حسابك : ${Verify} , مع العلم انه يجب عليك تغيير كلمة المرور عند اول عملية تسجيل دخول`,
  });
};

module.exports = {
  sendWelcomeEmail,
  sendCancelationEmail,
  ForgetPassEmail,
};
