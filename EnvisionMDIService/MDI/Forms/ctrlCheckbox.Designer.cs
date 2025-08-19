namespace MDI.Forms
{
    partial class ctrlCheckbox
    {
        /// <summary> 
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary> 
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Component Designer generated code

        /// <summary> 
        /// Required method for Designer support - do not modify 
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.lblImage = new System.Windows.Forms.Label();
            this.lblText = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // lblImage
            // 
            this.lblImage.Dock = System.Windows.Forms.DockStyle.Left;
            this.lblImage.Image = global::MDI.Properties.Resources.check_state_checked_24;
            this.lblImage.Location = new System.Drawing.Point(0, 0);
            this.lblImage.Name = "lblImage";
            this.lblImage.Size = new System.Drawing.Size(37, 37);
            this.lblImage.TabIndex = 0;
            this.lblImage.Click += new System.EventHandler(this.ctrlCheckbox_Click);
            // 
            // lblText
            // 
            this.lblText.Dock = System.Windows.Forms.DockStyle.Fill;
            this.lblText.Font = new System.Drawing.Font("Microsoft Sans Serif", 21.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(222)));
            this.lblText.ForeColor = System.Drawing.Color.White;
            this.lblText.Location = new System.Drawing.Point(37, 0);
            this.lblText.Name = "lblText";
            this.lblText.Size = new System.Drawing.Size(163, 37);
            this.lblText.TabIndex = 1;
            this.lblText.Text = "Text";
            this.lblText.Click += new System.EventHandler(this.ctrlCheckbox_Click);
            // 
            // ctrlCheckbox
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackgroundImageLayout = System.Windows.Forms.ImageLayout.None;
            this.Controls.Add(this.lblText);
            this.Controls.Add(this.lblImage);
            this.DoubleBuffered = true;
            this.MinimumSize = new System.Drawing.Size(0, 37);
            this.Name = "ctrlCheckbox";
            this.Size = new System.Drawing.Size(200, 37);
            this.Click += new System.EventHandler(this.ctrlCheckbox_Click);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Label lblImage;
        private System.Windows.Forms.Label lblText;
    }
}
