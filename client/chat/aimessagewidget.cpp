#include "aimessagewidget.h"
#include <QPixmap>
#include <QVBoxLayout>

AiMessageWidget::AiMessageWidget(const QString& avatarPath, const QString& message, bool isUser, QWidget *parent)
    : QWidget(parent), isUserMessage(isUser)
{
    avatarLabel = new QLabel(this);
    avatarLabel->setPixmap(QPixmap(avatarPath).scaled(40, 40, Qt::KeepAspectRatio, Qt::SmoothTransformation));
    avatarLabel->setFixedSize(40, 40); // 固定头像大小

    messageLabel = new QLabel(this);
    messageLabel->setText(message);
    messageLabel->setWordWrap(true); // 自动换行
    messageLabel->setTextInteractionFlags(Qt::TextSelectableByMouse); // 允许鼠标选择文本
    messageLabel->setSizePolicy(QSizePolicy::Fixed, QSizePolicy::Preferred);

    // 设置消息的样式
    if (isUser) {
        messageLabel->setStyleSheet("background-color: #DCF8C6; padding: 8px; border-radius: 5px;"); // 浅绿色
    } else {
        messageLabel->setStyleSheet("background-color: #ADD8E6; padding: 8px; border-radius: 5px;"); // 浅蓝色
    }

    // 头像布局，保持头像在顶部
    QVBoxLayout* avatarLayout = new QVBoxLayout();
    avatarLayout->addWidget(avatarLabel);
    avatarLayout->addStretch();

    layout = new QHBoxLayout(this);

    if (isUser) {
        // 用户消息，头像在右边
        layout->addStretch();
        layout->addWidget(messageLabel);
        layout->addLayout(avatarLayout);
    } else {
        // AI 消息，头像在左边
        layout->addLayout(avatarLayout);
        layout->addWidget(messageLabel);
        layout->addStretch();
    }

    layout->setContentsMargins(5, 5, 5, 5);
    setLayout(layout);

    // 设置消息Label的最大宽度，避免过宽
    messageLabel->setMaximumWidth(400); // 可以根据需要调整最大宽度
}

void AiMessageWidget::updateMessage(const QString& newMessage)
{
    messageLabel->setText(newMessage);

    // 动态设置消息Label的最大宽度
    int maxWidth = parentWidget()->width() * 0.8; // 消息气泡占父窗口的80%
    messageLabel->setMaximumWidth(maxWidth);

    messageLabel->adjustSize();

    // 更新整个Widget的大小
    adjustSize();
    updateGeometry();
}

QSize AiMessageWidget::sizeHint() const
{
    QSize size = layout->sizeHint();
    return size;
}
