;;; early-init.el --- Early configuration settings -*- lexical-binding: t -*-

;; -----------------------------------------------------------------------------
;; 1. 垃圾回收 （GC）性能优化
;; -----------------------------------------------------------------------------
;; 启动时大幅增加阈值，减少 GC 次数，启动后需在 init.el 中恢复
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)

;; -----------------------------------------------------------------------------
;; 2. UI 预设
;; -----------------------------------------------------------------------------
;; 彻底从底层参数级禁用 UI 元素，确保窗口弹出时就是干净的
(setq default-frame-alist
      '((menu-bar-lines . 0)          ; 菜单栏
        (tool-bar-lines . 0)          ; 工具栏
        (vertical-scroll-bars)        ; 垂直滚动条
        (horizontal-scroll-bars)      ; 水平滚动条
        (internal-border-width . 0))) ; 内部边距

(menu-bar-mode -1)
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(when (fboundp 'horizontal-scroll-bar-mode) (horizontal-scroll-bar-mode -1))

;; -----------------------------------------------------------------------------
;; 3. 启动设置
;; -----------------------------------------------------------------------------
;; 禁止显示启动画面和多余信息
(setq inhibit-startup-screen t
      inhibit-startup-echo-area-message "xi" ; Must match your system username
      initial-scratch-message nil            ; Empty scratch buffer
      initial-major-mode 'text-mode)         ; Use text-mode for scratch

(provide 'early-init)
