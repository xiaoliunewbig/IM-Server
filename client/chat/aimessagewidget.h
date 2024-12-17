#ifndef AIMESSAGEWIDGET_H
#define AIMESSAGEWIDGET_H

#include <QWidget>
#include <QLabel>
#include <QHBoxLayout>

class AiMessageWidget :public QWidget
{
    Q_OBJECT
public:
    explicit AiMessageWidget(const QString& avatarPath, const QString& message, bool isUser, QWidget *parent = nullptr);
    void updateMessage(const QString& newMessage);

    // 重写 sizeHint 方法
    QSize sizeHint() const override;

private:
    QLabel* avatarLabel;    // 头像标签
    QLabel* messageLabel;   // 消息内容标签
    QHBoxLayout* layout;    // 布局
    bool isUserMessage;     // 是否为用户消息
};

#endif // AIMESSAGEWIDGET_H
