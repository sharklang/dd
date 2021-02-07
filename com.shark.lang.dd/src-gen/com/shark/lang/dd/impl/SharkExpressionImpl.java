/**
 * generated by Xtext 2.23.0
 */
package com.shark.lang.dd.impl;

import com.shark.lang.dd.DdPackage;
import com.shark.lang.dd.SharkExpression;

import org.eclipse.emf.common.notify.Notification;

import org.eclipse.emf.ecore.EClass;

import org.eclipse.emf.ecore.impl.ENotificationImpl;
import org.eclipse.emf.ecore.impl.MinimalEObjectImpl;

/**
 * <!-- begin-user-doc -->
 * An implementation of the model object '<em><b>Shark Expression</b></em>'.
 * <!-- end-user-doc -->
 * <p>
 * The following features are implemented:
 * </p>
 * <ul>
 *   <li>{@link com.shark.lang.dd.impl.SharkExpressionImpl#getExprValue <em>Expr Value</em>}</li>
 *   <li>{@link com.shark.lang.dd.impl.SharkExpressionImpl#getHasAttribute <em>Has Attribute</em>}</li>
 * </ul>
 *
 * @generated
 */
public class SharkExpressionImpl extends MinimalEObjectImpl.Container implements SharkExpression
{
  /**
   * The default value of the '{@link #getExprValue() <em>Expr Value</em>}' attribute.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @see #getExprValue()
   * @generated
   * @ordered
   */
  protected static final String EXPR_VALUE_EDEFAULT = null;

  /**
   * The cached value of the '{@link #getExprValue() <em>Expr Value</em>}' attribute.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @see #getExprValue()
   * @generated
   * @ordered
   */
  protected String exprValue = EXPR_VALUE_EDEFAULT;

  /**
   * The default value of the '{@link #getHasAttribute() <em>Has Attribute</em>}' attribute.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @see #getHasAttribute()
   * @generated
   * @ordered
   */
  protected static final int HAS_ATTRIBUTE_EDEFAULT = 0;

  /**
   * The cached value of the '{@link #getHasAttribute() <em>Has Attribute</em>}' attribute.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @see #getHasAttribute()
   * @generated
   * @ordered
   */
  protected int hasAttribute = HAS_ATTRIBUTE_EDEFAULT;

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  protected SharkExpressionImpl()
  {
    super();
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  @Override
  protected EClass eStaticClass()
  {
    return DdPackage.Literals.SHARK_EXPRESSION;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  @Override
  public String getExprValue()
  {
    return exprValue;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  @Override
  public void setExprValue(String newExprValue)
  {
    String oldExprValue = exprValue;
    exprValue = newExprValue;
    if (eNotificationRequired())
      eNotify(new ENotificationImpl(this, Notification.SET, DdPackage.SHARK_EXPRESSION__EXPR_VALUE, oldExprValue, exprValue));
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  @Override
  public int getHasAttribute()
  {
    return hasAttribute;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  @Override
  public void setHasAttribute(int newHasAttribute)
  {
    int oldHasAttribute = hasAttribute;
    hasAttribute = newHasAttribute;
    if (eNotificationRequired())
      eNotify(new ENotificationImpl(this, Notification.SET, DdPackage.SHARK_EXPRESSION__HAS_ATTRIBUTE, oldHasAttribute, hasAttribute));
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  @Override
  public Object eGet(int featureID, boolean resolve, boolean coreType)
  {
    switch (featureID)
    {
      case DdPackage.SHARK_EXPRESSION__EXPR_VALUE:
        return getExprValue();
      case DdPackage.SHARK_EXPRESSION__HAS_ATTRIBUTE:
        return getHasAttribute();
    }
    return super.eGet(featureID, resolve, coreType);
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  @Override
  public void eSet(int featureID, Object newValue)
  {
    switch (featureID)
    {
      case DdPackage.SHARK_EXPRESSION__EXPR_VALUE:
        setExprValue((String)newValue);
        return;
      case DdPackage.SHARK_EXPRESSION__HAS_ATTRIBUTE:
        setHasAttribute((Integer)newValue);
        return;
    }
    super.eSet(featureID, newValue);
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  @Override
  public void eUnset(int featureID)
  {
    switch (featureID)
    {
      case DdPackage.SHARK_EXPRESSION__EXPR_VALUE:
        setExprValue(EXPR_VALUE_EDEFAULT);
        return;
      case DdPackage.SHARK_EXPRESSION__HAS_ATTRIBUTE:
        setHasAttribute(HAS_ATTRIBUTE_EDEFAULT);
        return;
    }
    super.eUnset(featureID);
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  @Override
  public boolean eIsSet(int featureID)
  {
    switch (featureID)
    {
      case DdPackage.SHARK_EXPRESSION__EXPR_VALUE:
        return EXPR_VALUE_EDEFAULT == null ? exprValue != null : !EXPR_VALUE_EDEFAULT.equals(exprValue);
      case DdPackage.SHARK_EXPRESSION__HAS_ATTRIBUTE:
        return hasAttribute != HAS_ATTRIBUTE_EDEFAULT;
    }
    return super.eIsSet(featureID);
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  @Override
  public String toString()
  {
    if (eIsProxy()) return super.toString();

    StringBuilder result = new StringBuilder(super.toString());
    result.append(" (exprValue: ");
    result.append(exprValue);
    result.append(", hasAttribute: ");
    result.append(hasAttribute);
    result.append(')');
    return result.toString();
  }

} //SharkExpressionImpl
