namespace MDI.Forms
{
    partial class ctrlObservation
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
            this.lblObservation = new System.Windows.Forms.Label();
            this.lblIdentifier = new System.Windows.Forms.Label();
            this.lblUnit = new System.Windows.Forms.Label();
            this.lblMinMax = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // lblObservation
            // 
            this.lblObservation.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.lblObservation.BackColor = System.Drawing.Color.White;
            this.lblObservation.Font = new System.Drawing.Font("Microsoft Sans Serif", 24F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(222)));
            this.lblObservation.ForeColor = System.Drawing.Color.Black;
            this.lblObservation.Location = new System.Drawing.Point(3, 25);
            this.lblObservation.Name = "lblObservation";
            this.lblObservation.Size = new System.Drawing.Size(194, 55);
            this.lblObservation.TabIndex = 0;
            this.lblObservation.Text = "VALUE";
            this.lblObservation.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            this.lblObservation.TextChanged += new System.EventHandler(this.lblObservation_TextChanged);
            this.lblObservation.Click += new System.EventHandler(this.ctrlObservation_Click);
            // 
            // lblIdentifier
            // 
            this.lblIdentifier.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.lblIdentifier.Font = new System.Drawing.Font("Microsoft Sans Serif", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblIdentifier.Location = new System.Drawing.Point(0, 0);
            this.lblIdentifier.Name = "lblIdentifier";
            this.lblIdentifier.Size = new System.Drawing.Size(200, 25);
            this.lblIdentifier.TabIndex = 1;
            this.lblIdentifier.Text = "Identifier";
            this.lblIdentifier.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.lblIdentifier.Click += new System.EventHandler(this.ctrlObservation_Click);
            // 
            // lblUnit
            // 
            this.lblUnit.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.lblUnit.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(222)));
            this.lblUnit.Location = new System.Drawing.Point(150, 80);
            this.lblUnit.Name = "lblUnit";
            this.lblUnit.Size = new System.Drawing.Size(50, 16);
            this.lblUnit.TabIndex = 2;
            this.lblUnit.Text = "XXXXXX";
            this.lblUnit.TextAlign = System.Drawing.ContentAlignment.TopRight;
            this.lblUnit.Click += new System.EventHandler(this.ctrlObservation_Click);
            // 
            // lblMinMax
            // 
            this.lblMinMax.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.lblMinMax.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(222)));
            this.lblMinMax.Location = new System.Drawing.Point(0, 80);
            this.lblMinMax.Name = "lblMinMax";
            this.lblMinMax.Size = new System.Drawing.Size(150, 16);
            this.lblMinMax.TabIndex = 3;
            this.lblMinMax.Text = "XXXXXX";
            // 
            // ctrlObservation
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.DodgerBlue;
            this.Controls.Add(this.lblMinMax);
            this.Controls.Add(this.lblIdentifier);
            this.Controls.Add(this.lblObservation);
            this.Controls.Add(this.lblUnit);
            this.MinimumSize = new System.Drawing.Size(96, 96);
            this.Name = "ctrlObservation";
            this.Size = new System.Drawing.Size(200, 96);
            this.Load += new System.EventHandler(this.ctrlObservation_Load);
            this.Click += new System.EventHandler(this.ctrlObservation_Click);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Label lblObservation;
        private System.Windows.Forms.Label lblIdentifier;
        private System.Windows.Forms.Label lblUnit;
        private System.Windows.Forms.Label lblMinMax;
    }
}
